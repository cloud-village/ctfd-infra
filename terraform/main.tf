module "ctfd_alb" {
  source          = "./alb"
  subnets         = var.alb_subnets
  vpc_id          = var.vpc_id
  certificate_arn = var.certificate_arn
  instance_sg_id  = module.ctfd_launch_template.instance_sg.id
  inbound_ips     = var.inbound_ips
}

module "iam_profile" {
  source              = "./iam"
  uploads_bucket_name = module.s3_uploads.uploads_bucket.id
}

module "s3_uploads" {
  source              = "./s3_uploads"
  uploads_bucket_name = uuid()
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
  source = "./ecs"
}
