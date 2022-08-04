resource "aws_elasticache_cluster" "cache" {
  cluster_id               = "ctfd-cache"
  engine                   = "redis"
  node_type                = var.node_type
  num_cache_nodes          = 1
  parameter_group_name     = "default.redis3.2"
  engine_version           = "3.2.10"
  port                     = 6379
  security_group_ids       = [aws_security_group.allow_redis.id]
  snapshot_window          = "05:00-09:00"
  snapshot_retention_limit = var.snapshot_retention_limit
}

resource "aws_security_group" "allow_redis" {
  name        = "allow_redis"
  description = "Allow redis inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "redis"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_redis"
  }
}

