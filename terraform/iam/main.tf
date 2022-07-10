data "aws_caller_identity" "current" {}

locals {
  # if name_override is not provided, use "ctfd", else append name_override to "ctfd"
  name = var.name_override == "" ? "ctfd" : "ctfd-${var.name_override}"
}

# create a user because app doesn't support roles :grimace:
resource "aws_iam_access_key" "ctfd" {
  user = aws_iam_user.ctfd.name
}

resource "aws_iam_user" "ctfd" {
  name = local.name
}

# IAM policy to upload files to s3
resource "aws_iam_policy" "s3_policy" {
  name        = "${local.name}_s3_upload_access"
  path        = "/"
  description = "allow uploads to s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Put*",
          "s3:Get*",
          "s3:List*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::${var.uploads_bucket_name}",
          "arn:aws:s3:::${var.uploads_bucket_name}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "s3_access_attach" {
  user       = aws_iam_user.ctfd.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# add s3 access user details to SSM
resource "aws_ssm_parameter" "s3_access" {
  name  = "/${local.name}/s3/access"
  type  = "SecureString"
  value = aws_iam_access_key.ctfd.id
}

resource "aws_ssm_parameter" "s3_secret" {
  name  = "/${local.name}/s3/secret"
  type  = "SecureString"
  value = aws_iam_access_key.ctfd.secret
}

# role for ECS
resource "aws_iam_role" "role" {
  name = "ctfd-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = "ECSTasksAssumeRole"
      }
    ]
  })
}

# IAM policy for ECS task
resource "aws_iam_policy" "ctfd_ecs_policy" {
  name        = "ctfd_ecs_policy"
  description = "provide CTFd in ECS access to ASM, SSM Parameter Store, and logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ssm:GetParameters"
        Effect   = "Allow"
        Resource = "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${local.name}/*"
      },
      {
        Action   = "secretsmanager:GetSecretValue"
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:/${local.name}/*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ctfd_ecs_policy.arn
}

