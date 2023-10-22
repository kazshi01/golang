resource "aws_ecs_service" "ecs_service" {
  name            = "${var.name}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 1
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]

  launch_type = "FARGATE"

  network_configuration {
    subnets         = module.vpc.public_subnet_ids
    security_groups = [aws_security_group.example.id]
  }

  ordered_placement_strategy {
    # CPU未使用率が低いコンテナから配置
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}
