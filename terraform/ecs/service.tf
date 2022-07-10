resource "aws_ecs_service" "ctfd" {
  name             = "${local.name}-service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.arn
  desired_count    = var.desired_count
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "ctfd"
    container_port   = 8000
  }

  # Allow changes via autoscaling without appearing in Terraform plan diff
  lifecycle {
    ignore_changes = [desired_count]
  }
}

