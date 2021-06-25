resource "aws_ecs_service" "ctfd" {
  name            = "ctfd-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 3
  launch_type     = "FARGATE"

  iam_role   = var.iam_role_arn
  depends_on = [var.iam_role_policy]

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "ctfd"
    container_port   = 8000
  }

}

