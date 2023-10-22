resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name}-ecs-cluster"

  #CloudWatch Container Insightsが有効
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
