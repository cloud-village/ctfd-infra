resource "aws_ecs_cluster" "cluster" {
  name = "${local.name}-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
