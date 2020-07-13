output "redis" {
  value = aws_elasticache_cluster.cache
}

output "redis_sg" {
  value = aws_security_group.allow_redis
}
