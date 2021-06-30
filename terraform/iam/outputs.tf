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
  value = aws_ssm_parameter.s3_access
}
output "s3_secret" {
  value = aws_ssm_parameter.s3_secret
}
