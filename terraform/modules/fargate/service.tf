resource "aws_ecs_service" "ecs_service" {
  name            = "${var.name}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1
  # !!!Fargateでは不要!!! Service Role(ELB、Auto Scalingなどとの連携に必要)
  # iam_role   = aws_iam_role.ecs_service_role.arn
  # depends_on = [aws_iam_role.ecs_service_role]

  launch_type = "FARGATE"

  network_configuration {
    subnets         = module.network.public_subnet_ids
    security_groups = [aws_security_group.service_sg.id]
    # Private Subnetに配置する場合は、以下の設定をfalseにする
    assign_public_ip = var.assign_public_ip
  }
  # !!!Fargateでは不要!!!
  # ordered_placement_strategy {
  #   # CPU未使用率が低いコンテナから配置
  #   type  = "binpack"
  #   field = "cpu"
  # }

  load_balancer {
    target_group_arn = module.network.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}
