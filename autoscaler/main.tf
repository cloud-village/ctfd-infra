module "ctfd_launch_template" {
  source = "./launch_template"
  iam_instance_profile_name = "" #TK
  image_id  = "" #TK
  availability_zone = "" #TK
}

module "ctfd_autoscaling_group" {
  source = "./autoscaling_group"
  availability_zones  = "" #TK
  desired_capacity = "" #TK
  max_size = "" #TK
  launch_template_id = module.ctfd-launch-template.id
  target_group_arns = module.ctfd_alb.ctfd_target_group.arn
}

module "ctfd_alb" {
  source = "./alb"
  subnets = "" #TK
  alb_logs_bucket_name = "" #TK
  vpc_id = "" #TK
  certificate_arn = "" #TK
}
