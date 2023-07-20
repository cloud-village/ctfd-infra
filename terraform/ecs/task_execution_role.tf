resource "aws_iam_role" "ecs_task_execution" {
  name = "${local.name}-ecs-task-execution"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_policy.json
}

#TODO rename
data "aws_iam_policy_document" "ecs_task_execution_policy" {
  statement {
    sid    = "ECSAssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole"
    ]

  }
}

data "aws_iam_policy_document" "ecs_exec" {
  statement {
    sid    = "ECSExec"
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_exec" {
  name        = "${local.name}-ecs-exec"
  description = "enable ecs exec"
  policy      = data.aws_iam_policy_document.ecs_exec.json
}

resource "aws_iam_role_policy_attachment" "ecs_exec" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_exec.arn
}
