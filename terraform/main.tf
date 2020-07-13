module "ctfd_launch_template" {
  source                    = "./launch_template"
  iam_instance_profile_name = module.iam_profile.profile.name
  image_id                  = "" #TK
  availability_zone         = "" #TK
  key_name                  = "" #TK
  vpc_id                    = "" #TK
}

module "ctfd_autoscaling_group" {
  source             = "./autoscaling_group"
  availability_zones = "" #TK
  desired_capacity   = "" #TK
  max_size           = "" #TK
  launch_template_id = module.ctfd_launch_template.cftd_template.id
  target_group_arns  = module.ctfd_alb.ctfd_target_group.arn
}

module "ctfd_alb" {
  source          = "./alb"
  subnets         = "" #TK
  vpc_id          = "" #TK
  certificate_arn = "" #TK
  instance_sg_id  = module.ctfd_autoscaling_group.instance_sg.id
}

module "iam_profile" {
  source              = "./iam"
  uploads_bucket_name = module.s3_uploads.uploads_bucket.id
}

module "s3_uploads" {
  source              = "./s3_uploads"
  uploads_bucket_name = "" #TK
}

module "dns" {
  source       = "./dns"
  zone_id      = "" #TK
  alb_dns_name = module.ctfd_alb.ctfd_alb.dns_name
  alb_zone_id  = module.ctfd_alb.ctfd_alb.zone_id
}
