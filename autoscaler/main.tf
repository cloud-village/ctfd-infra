module "ctfd_launch_template" {
  source = "./launch-template"
  iam_instance_profile_name = "" #TK
  image_id  = "" #TK
  availability_zone = "" #TK
  vpc_security_group_ids = "" #TK
}

module "ctfd_autoscaling_group" {
  source = "./autoscaling_group"
  availability_zones  = "" #TK
  desired_capacity = "" #TK
  max_size = "" #TK
  launch_template_id = module.ctfd-launch-template.id
}

module "ctfd_alb" {
  source = "./alb"
  security_groups = "" #TK
  subnets = "" #TK
  alb_logs_bucket_name = "" #TK
  vpc_id = "" #TK
  certificate_arn = "" #TK
}
