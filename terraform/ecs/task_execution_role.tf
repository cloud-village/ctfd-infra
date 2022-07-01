resource "aws_iam_role" "ecs_task_execution" {
  name = "ecs-task-execution"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_policy.json
}

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
