resource "aws_codedeploy_app" "ecs_app" {
  compute_platform = "ECS"
  name             = "${var.name}-ecs-app"
}

resource "aws_codedeploy_deployment_group" "ecs_deployment_group" {
  app_name              = aws_codedeploy_app.ecs_app.name
  deployment_group_name = "${var.name}-ecs-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL" // ここでALBの切り替えを有効化
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
      # 手動で切り替える場合は以下のように設定
      # action_on_timeout    = "STOP_DEPLOYMENT"
      # wait_time_in_minutes = 60
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5 // ここでBlue環境のインスタンスを終了するまでの待機時間を設定
    }
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      target_group {
        name = var.bule_target_group_name // ここでBlue環境のALBのターゲットグループを指定
      }
      target_group {
        name = var.green_target_group_name // ここでGreen環境のALBのターゲットグループを指定
      }
      prod_traffic_route {
        listener_arns = [var.https_listener_arn] // ここでALBのリスナー(443ポート)を指定
      }
    }
  }
}
