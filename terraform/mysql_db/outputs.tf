output "db_uri" {
  value = aws_secretsmanager_secret.db_uri
}

output "db_security_group" {
  value = aws_security_group.allow_mysql
}
