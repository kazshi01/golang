#####################
#    SERVICE ROLE   #
#####################

# !!!Fargaetでは不要!!!

# resource "aws_iam_role" "ecs_service_role" {
#   name = "ecs-service-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ecs.amazonaws.com"
#         }
#       }
#     ]
#   })
# }
# ロールにService権限を付与する（EC2、ELBなどの権限を付与）
# resource "aws_iam_role_policy_attachment" "ecs_service_role_attachment" {
#   role       = aws_iam_role.ecs_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
# }
# ロールにAuto Scaling権限を付与する
# resource "aws_iam_role_policy_attachment" "ecs_autoscale_attachment" {
#   role       = aws_iam_role.ecs_service_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
# }

#####################
#TASK EXECUTION ROLE#
#####################
resource "aws_iam_role" "ecs_execution_role" {
  name = "my-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}
# ロールにTask Execution権限を付与する（ECR、CloudWatch）
resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#####################
#     TASK ROLE     #
#####################
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# ロールにEFSへの権限を付与する
resource "aws_iam_role_policy_attachment" "ecs_task_efs_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
}

## ECS Execコマンド用の権限を付与する
resource "aws_iam_policy" "ecs_execute_command_policy" {
  name        = "ecs_execute_command_policy"
  description = "A policy to allow execute-command action"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action   = "kms:Decrypt",
        Effect   = "Allow",
        Resource = "${aws_kms_key.cloudwatch_logs_key.arn}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execute_command_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_execute_command_policy.arn
}
