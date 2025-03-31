resource "aws_appautoscaling_target" "asg_target" {
  max_capacity       = 5
  min_capacity       = var.desired_count
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.ctfd.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "cpu" {
  name               = "${local.name}-cpu-poilcy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.asg_target.resource_id
  scalable_dimension = aws_appautoscaling_target.asg_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.asg_target.service_namespace

  target_tracking_scaling_policy_configuration {
    scale_in_cooldown = 60
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = var.max_cpu_threshold
  }
}
