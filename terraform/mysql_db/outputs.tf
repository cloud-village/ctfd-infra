output "db_instance" {
  value = aws_db_instance.default
}

output "db_security_group" {
  value = aws_security_group.allow_mysql
}
