resource "aws_ecs_cluster" "cluster" {
  name = "ctfd-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
