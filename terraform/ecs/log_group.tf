resource "aws_cloudwatch_log_group" "ctfd_logs" {
  name = "/ecs/${local.task_family_name}"
}
