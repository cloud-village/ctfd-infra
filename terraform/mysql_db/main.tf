resource "random_password" "random" {
  length = 22
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "ctfd-db"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = var.availability_zones
  database_name           = "ctfd"
  master_username         = "ctfd"
  master_password         = random_password.random.result
  backup_retention_period = 5
  copy_tags_to_snapshot   = true
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.allow_mysql.id]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = length(var.availability_zones)
  identifier         = "ctfd-db-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow mysql inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
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
    Name = "allow_mysql"
  }
}

resource "aws_secretsmanager_secret" "url" {
  name = "/ctfd/database/url"
}

resource "aws_secretsmanager_secret_version" "url" {
  secret_id     = aws_secretsmanager_secret.url.id
  secret_string = aws_rds_cluster.default.endpoint
}

resource "aws_secretsmanager_secret" "pass" {
  name = "/ctfd/database/pass"
}

resource "aws_secretsmanager_secret_version" "pass" {
  secret_id     = aws_secretsmanager_secret.pass.id
  secret_string = random_password.random.result
}

