output "db_cluster" {
  value = aws_rds_cluster.default
}

output "db_instances" {
  value = aws_rds_cluster_instance.cluster_instances[*]
}

output "pass" {
  value = random_password.random
}

output "db_security_group" {
  value = aws_security_group.allow_mysql
}
