resource "aws_ecs_task_definition" "task" {
  family             = local.name
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
      linux_parameters = {
        init_process_enabled = "true"
      }

      "secrets" : [
        { "name" : "AWS_ACCESS_KEY_ID", "valueFrom" : var.aws_access_key_arn },
        { "name" : "AWS_SECRET_ACCESS_KEY", "valueFrom" : var.aws_secret_access_key_arn },
        { "name" : "MAIL_USERNAME", "valueFrom" : var.mail_username_arn },
        { "name" : "MAIL_PASSWORD", "valueFrom" : var.mail_password_arn },
        { "name" : "DATABASE_URL", "valueFrom" : var.database_url_arn },

      ],

      "environment" : [
        { "name" : "AWS_S3_BUCKET", "value" : "${var.s3_bucket}" },
        { "name" : "MAILFROM_ADDR", "value" : "${var.mailfrom_addr}" },
        { "name" : "MAIL_SERVER", "value" : "${var.mail_server}" },
        { "name" : "MAIL_PORT", "value" : "${var.mail_port}" },
        { "name" : "MAIL_TLS", "value" : tostring(var.mail_tls) },
        { "name" : "MAIL_USEAUTH", "value" : "true" },
        { "name" : "REDIS_URL", "value" : "redis://${var.redis_url}" },
        { "name" : "REVERSE_PROXY", "value" : "True" },
        { "name" : "SECRET_KEY", "value" : "${var.secret_key}" },
        { "name" : "UPLOAD_PROVIDER", "value" : "s3" },
        { "name" : "WORKERS", "value" : "${var.workers}" },
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
  ])

  requires_compatibilities = ["FARGATE"]

  tags = {
    name         = local.name
    ctfd_version = var.ctfd_version
  }

}


