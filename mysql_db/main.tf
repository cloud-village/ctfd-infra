resource "random_string" "random" {
  length = 22
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "ctfd-db"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = var.availability_zones
  database_name           = "ctfd-db"
  master_username         = "foo"
  master_password         = random_string.random.result
  backup_retention_period = 5
  copy_tags_to_snapshot   = true
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = length(var.availability_zones)
  identifier         = "ctfd-db-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

