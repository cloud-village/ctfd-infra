resource "random_string" "random" {
  length = 22
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "ctfd-db"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = var.availability_zones
  database_name           = "ctfddb"
  master_username         = "ctfd"
  master_password         = random_string.random.result
  backup_retention_period = 5
  copy_tags_to_snapshot   = true
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  vpc_security_group_ids  = aws_security_group.allow_mysql.id
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
    description     = "mysql"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = self
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

