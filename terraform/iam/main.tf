data "aws_caller_identity" "current" {}


# create a user because app doesn't support roles :grimace:
resource "aws_iam_access_key" "ctfd" {
  user = aws_iam_user.ctfd.name
}

resource "aws_iam_user" "ctfd" {
  name = "ctfd"
}

# IAM policy to upload files to s3
resource "aws_iam_policy" "s3_policy" {
  name        = "ctfd_s3_upload_access"
  path        = "/"
  description = "allow uploads to s3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:Put*",
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

# add s3 access user details to ASM
resource "aws_secretsmanager_secret" "s3_access" {
  name = "/ctfd/s3/access"
}

resource "aws_secretsmanager_secret_version" "s3_access" {
  secret_id     = aws_secretsmanager_secret.s3_access.id
  secret_string = aws_iam_access_key.ctfd.id
}

resource "aws_secretsmanager_secret" "s3_secret" {
  name = "/ctfd/s3/secret"
}

resource "aws_secretsmanager_secret_version" "s3_secret" {
  secret_id     = aws_secretsmanager_secret.s3_secret.id
  secret_string = aws_iam_access_key.ctfd.secret
}




# role for ECS
resource "aws_iam_role" "role" {
  name = "ctfd-uploads-role"

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

# IAM policy for ECS to access secrets
resource "aws_iam_policy" "ctfd_secrets" {
  name        = "ctfd_asm_access"
  description = "ctfd role access to secrets in ASM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:*:${data.aws_caller_identity.current.account_id}:secret:/ctfd/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ctfd_secrets.arn
}

