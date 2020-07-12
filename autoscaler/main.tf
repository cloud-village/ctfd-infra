module "ctfd_launch_template" {
  source                    = "./launch_template"
  iam_instance_profile_name = "" #TK
  image_id                  = "" #TK
  availability_zone         = "" #TK
}

module "ctfd_autoscaling_group" {
  source             = "./autoscaling_group"
  availability_zones = "" #TK
  desired_capacity   = "" #TK
  max_size           = "" #TK
  launch_template_id = module.ctfd-launch-template.id
  target_group_arns  = module.ctfd_alb.ctfd_target_group.arn
}

module "ctfd_alb" {
  source               = "./alb"
  subnets              = "" #TK
  alb_logs_bucket_name = module.logs_bucket.logs_bucket.id
  vpc_id               = "" #TK
  certificate_arn      = "" #TK
  instance_sg_id       = module.ctfd_autoscaling_group.instance_sg.id
}

module "logs_bucket" {
  source = "./logs_bucket"
  name   = "" # TK
}

module "iam_profile" {
  source = "./iam"
  logs_bucket_name = module.logs_bucket.logs_bucket.id
}
