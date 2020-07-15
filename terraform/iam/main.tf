data "aws_caller_identity" "current" {}

resource "aws_iam_role" "role" {
  name = "ctfd-uploads-role"

  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "ctfd-access"
  description = "access policy for ctfd"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Put*"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.uploads_bucket_name}",
        "arn:aws:s3:::${var.uploads_bucket_name}/*"
      ]
    },
    {   
      "Action": [
        "secretsmanager:GetSecretValue"
      ],  
      "Effect": "Allow",
      "Resource": "arn:aws:secretsmanager:*:287417860444:secret:/ctfd/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "profile" {
  name = "ctfd-uploads-profile"
  role = aws_iam_role.role.name
}
