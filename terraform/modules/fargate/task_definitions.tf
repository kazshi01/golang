resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.name}-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = local.ecr_image
      cpu       = 256
      memory    = 512
      essential = true
      mountPoints = [
        {
          sourceVolume  = "service-storage",
          containerPath = "/opt/data" ## マウント先のパス
        }
      ],
      # コンテナへのユーザー指定
      # linuxParameters = {
      #   user = "1000:1000"
      # },
      portMappings = [
        {
          hostPort      = var.hostPort
          containerPort = var.containerPort
        }
      ],
      environment = [
        {
          name  = "DATABASE_HOST",
          value = module.network.postgres_endpoint
        },
        {
          name  = "DATABASE_PORT",
          value = "5432"
        },
        {
          name  = "DATABASE_NAME",
          value = var.db_name
        },
        {
          name  = "DATABASE_USER",
          value = var.db_username
        },
        {
          name  = "DATABASE_PASSWORD",
          value = var.db_password
        },
        {
          #ALBのDNS名を環境変数に設定(backendsのDNS名を設定)
          name  = "API_DOMAIN",
          value = "${var.domain_prefix_alb}.${var.domain_name}"
        },
        {
          #CloudFrontのDNS名を環境変数に設定(fontendのDNS名を設定)
          name  = "FE_URL",
          value = "http://localhost:3000"
        },
        {
          name  = "SECRET",
          value = "uu5pveql"
        }
      ],
      # secrets = [
      #   {
      #     name      = "DATABASE_PASSWORD",
      #     valueFrom = "arn:aws:secretsmanager:region:aws_account_id:secret:my_db_password_secret" # Secrets ManagerのシークレットのARN
      #   },
      #   {
      #     name      = "SECRET",
      #     valueFrom = "arn:aws:secretsmanager:region:aws_account_id:secret:server_secret" # Secrets ManagerのシークレットのARN
      #   }
      # ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.container_log.name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
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
      file_system_id          = module.network.efs_id
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
      authorization_config {
        access_point_id = module.network.access_point_id
        iam             = "ENABLED"
      }
    }
  }
}
