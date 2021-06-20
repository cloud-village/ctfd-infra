output "ecs_role" {
  value = aws_iam_role.role
}

output "ctfd_s3_policy" {
  value = aws_iam_policy.s3_policy
}

output "ctfd_secrets_policy" {
  value = aws_iam_policy.ctfd_secrets
}

