module "ctfd_launch_template" {
  source                    = "./launch_template"
  iam_instance_profile_name = module.iam_profile.profile.name
  image_id                  = var.packer_image_id
  availability_zone         = var.template_az
  key_name                  = var.key_name
  vpc_id                    = var.vpc_id
  db_security_group         = module.mysql_db.db_security_group.id
}

module "ctfd_autoscaling_group" {
  source             = "./autoscaling_group"
  availability_zones = var.availability_zones
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  launch_template_id = module.ctfd_launch_template.cftd_template.id
  target_group_arns  = module.ctfd_alb.ctfd_target_group.arn
}

module "ctfd_alb" {
  source          = "./alb"
  subnets         = var.alb_subnets
  vpc_id          = var.vpc_id
  certificate_arn = var.certificate_arn
  instance_sg_id  = module.ctfd_launch_template.instance_sg.id
}

module "iam_profile" {
  source              = "./iam"
  uploads_bucket_name = module.s3_uploads.uploads_bucket.id
}

module "s3_uploads" {
  source              = "./s3_uploads"
  uploads_bucket_name = var.uploads_bucket_name
}

module "dns" {
  source       = "./dns"
  zone_id      = var.route53_zone_id
  alb_dns_name = module.ctfd_alb.ctfd_alb.dns_name
  alb_zone_id  = module.ctfd_alb.ctfd_alb.zone_id
}

module "mysql_db" {
  source             = "./mysql_db"
  availability_zones = var.availability_zones
  vpc_id             = var.vpc_id
}
