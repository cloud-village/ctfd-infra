module "ctfd_alb" { # TODO: update
  source          = "./alb"
  subnets         = var.alb_subnets
  vpc_id          = var.vpc_id
  certificate_arn = var.certificate_arn
  inbound_ips     = var.inbound_ips
}

module "iam" {
  source              = "./iam"
  uploads_bucket_name = module.s3_uploads.uploads_bucket.id
}

module "s3_uploads" {
  source              = "./s3_uploads"
  uploads_bucket_name = "ctfd-uploads-${random_string.bucket_seed.result}"
}

module "mysql_db" {
  source             = "./mysql_db"
  availability_zones = var.availability_zones
  vpc_id             = var.vpc_id
}

module "redis" {
  source    = "./redis"
  node_type = var.redis_node_type
  vpc_id    = var.vpc_id
}

module "ecs" {
  source                    = "./ecs"
  ctfd_version              = var.ctfd_version
  aws_access_key_arn        = module.iam.s3_access.arn
  aws_secret_access_key_arn = module.iam.s3_secret.arn
  mail_username_arn         = "placeholder"        # TODO: ASM? vars? IDK
  mail_password_arn         = "also a placeholder" # TODO: ASM? vars? IDK
  database_url_arn          = module.mysql_db.db_uri.arn
  workers                   = var.workers
  secret_key                = random_string.secret_key.result
  s3_bucket                 = module.s3_uploads.uploads_bucket.id
  mailfrom_addr             = var.mailfrom_addr
  mail_server               = var.mail_server
  mail_port                 = var.mail_port
  redis_url                 = module.redis.redis.cache_nodes.address
  task_family_name          = "ctfd"
  logs_region               = var.region
  iam_role_arn              = module.iam.ecs_role
  iam_role_policy           = module.iam.ctfd_secrets_policy.id
  target_group_arn          = module.alb #TODO
  security_groups = [
    module.redis.redis_security_group.id,
    module.mysql_db.db_security_group.id
  ]
  subnets = var.subnets
}
