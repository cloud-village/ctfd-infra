resource "aws_autoscaling_group" "ctfd_asg" {
  name               = "ctfd_asg"
  availability_zones = var.availability_zones
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  health_check_type = "ELB"
  target_group_arns = [var.target_group_arns]

  termination_policies = ["OldestInstance", "OldestLaunchConfiguration"]

  depends_on = [var.asg_depends_on]
}

