output "cftd_template" {
  value = aws_launch_template.ctfd
}

output "instance_sg" {
  description = "security group to allow inbound traffic from the alb"
  value = aws_security_group.inbound_from_alb
}
