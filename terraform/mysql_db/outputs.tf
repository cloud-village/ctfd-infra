output "db_uri" {
  value = aws_ssm_parameter.db_uri
}

output "db_security_group" {
  value = aws_security_group.allow_mysql
}
