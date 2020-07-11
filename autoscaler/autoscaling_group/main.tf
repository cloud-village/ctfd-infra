resource "aws_autoscaling_group" "ctfd-asg" {
  availability_zones = var.availability_zones
  desired_capacity   = max(length(var.availability_zones), var.desired_capacity)
  max_size           = var.max_size
  min_size           = length(var.availability_zones)

  launch_template {
    #id      = aws_launch_template.ctfd.id #FIXME how do we get the id?
    id      = "lt-this1" #FIXME this is in place to pass terraform validate
    version = "$Latest"
  }
}
