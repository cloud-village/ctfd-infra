output "ecs_role" {
  value = aws_iam_role.role
}

output "ctfd_s3_policy" {
  value = aws_iam_policy.s3_policy
}

output "ctfd_ecs_policy" {
  value = aws_iam_policy.ctfd_ecs_policy
}

output "s3_access" {
  value = aws_secretsmanager_secret.s3_access
}
output "s3_secret" {
  value = aws_secretsmanager_secret.s3_secret
}
