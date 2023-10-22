resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.name}-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "first"
      image     = local.ecr_image
      cpu       = 256
      memory    = 512
      essential = true
      mountPoints = [
        {
          sourceVolume  = "service-storage",
          containerPath = "/opt/data"
        }
      ],
      portMappings = [
        {
          containerPort = var.container_port
        }
      ]
    },
    # {
    #   name      = "second"
    #   image     = "service-second"
    #   cpu       = 128 # Fargate対応の値に変更
    #   memory    = 256 # Fargate対応の値に変更
    #   essential = true
    #   portMappings = [
    #     {
    #       containerPort = 443
    #     }
    #   ]
    # }
  ])

  # EFSをマウントするための設定
  volume {
    name = "service-storage"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.fs.id
      root_directory          = "/opt/data"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
      authorization_config {
        access_point_id = aws_efs_access_point.test.id
        iam             = "ENABLED"
      }
    }
  }
}
