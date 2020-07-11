resource "aws_autoscaling_group" "ctfd-asg" {
  availability_zones = var.availability_zones
  desired_capacity   = max(length(var.availability_zones), var.desired_capacity)
  max_size           = var.max_size
  min_size           = length(var.availability_zones)

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  health_check_type = "ELB"
  target_group_arns = var.target_group_arns

  termination_policies = ["OldestInstance", "OldestLaunchConfiguration"]
}
