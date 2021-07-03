output "ctfd_alb" {
  value = aws_lb.ctfd_alb
}

output "ctfd_target_group" {
  value = aws_lb_target_group.ctfd_target_group
}

output "alb_to_ecs_security_group" {
  value = aws_security_group.inbound_from_alb
}
