resource "random_password" "random" {
  length = 22
  # URI constraints FTL :sob:
  special = false
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_db_instance" "default" {
  allocated_storage       = var.allocated_storage
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = var.instance_class
  name                    = "ctfd"
  username                = "ctfd"
  password                = random_password.random.result
  parameter_group_name    = "default.mysql5.7"
  backup_retention_period = 5
  copy_tags_to_snapshot   = true
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.default.id
  vpc_security_group_ids  = [aws_security_group.allow_mysql.id]
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

resource "aws_ssm_parameter" "db_uri" {
  name  = "/ctfd/db_uri"
  type  = "SecureString"
  value = "mysql+pymysql://ctfd:${random_password.random.result}@${aws_db_instance.default.endpoint}/ctfd"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.db_subnets
}
