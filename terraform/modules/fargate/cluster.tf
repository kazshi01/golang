resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name}-ecs-cluster"

  #CloudWatch Container Insightsが有効
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  ## EXECコマンドを実行するための設定
  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.cloudwatch_logs_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.container_log.name
      }
    }
  }
}
