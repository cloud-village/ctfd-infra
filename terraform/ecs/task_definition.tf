locals {
  task_family_name = var.task_family_name
}

resource "aws_ecs_task_definition" "task" {
  family             = local.task_family_name
  network_mode       = "awsvpc"
  cpu                = var.cpu
  memory             = var.memory
  execution_role_arn = var.execution_role_arn
  task_role_arn      = aws_iam_role.ecs_task_execution.arn

  # race conditions FTL, gotta wait to make sure
  depends_on = [var.ecs_task_depends_on]

  container_definitions = jsonencode([
    {
      name      = "ctfd"
      image     = "ctfd/ctfd:${var.ctfd_version}"
      essential = true

      "secrets" : [
        { "name" : "AWS_ACCESS_KEY_ID", "valueFrom" : var.aws_access_key_arn },
        { "name" : "AWS_SECRET_ACCESS_KEY", "valueFrom" : var.aws_secret_access_key_arn },
        { "name" : "MAIL_USERNAME", "valueFrom" : var.mail_username_arn },
        { "name" : "MAIL_PASSWORD", "valueFrom" : var.mail_password_arn },
        { "name" : "DATABASE_URL", "valueFrom" : var.database_url_arn },

      ],

      "environment" : [
        { "name" : "WORKERS", "value" : "${var.workers}" },
        { "name" : "SECRET_KEY", "value" : "${var.secret_key}" },
        { "name" : "AWS_S3_BUCKET", "value" : "${var.s3_bucket}" },
        { "name" : "MAILFROM_ADDR", "value" : "${var.mailfrom_addr}" },
        { "name" : "MAIL_SERVER", "value" : "${var.mail_server}" },
        { "name" : "MAIL_PORT", "value" : "${var.mail_port}" },
        { "name" : "REDIS_URL", "value" : "redis://${var.redis_url}" },
        { "name" : "UPLOAD_PROVIDER", "value" : "s3" },
        { "name" : "MAIL_USEAUTH", "value" : "true" },
      ],

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ctfd_logs.name
          awslogs-region        = var.logs_region
          awslogs-stream-prefix = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 8000
        }
      ]
    },
    {
      name      = "newrelic"
      image     = "newrelic/nri-ecs:1.8.1"

      "secrets" : [
        { "name" : "NRIA_LICENSE_KEY", "valueFrom" : var.nria_license_key_arn }
      ],

      "environment" : [
        { "name" : "NRIA_OVERRIDE_HOST_ROOT", "value" : "${var.nria_override_host_root}" },
        { "name" : "NRIA_IS_FORWARD_ONLY", "value" : "${var.nria_is_forward_only}" },
        { "name" : "FARGATE", "value" : "${var.fargate_nr}" },
        { "name" : "NRIA_PASSTHROUGH_ENVIRONMENT", "value" : "${var.nria_passthorugh_env}" },
        { "name" : "NRIA_CUSTOM_ATTRIBUTES", "value" : "${var.nria_custom_attributes}" },
      ],

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ctfd_logs.name
          awslogs-region        = var.logs_region
          awslogs-stream-prefix = "ecs"
        }
      }

    }
  ])

  requires_compatibilities = ["FARGATE"]

  tags = {
    name         = local.task_family_name
    ctfd_version = var.ctfd_version
  }

}
