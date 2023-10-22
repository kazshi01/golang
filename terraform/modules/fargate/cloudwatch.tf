resource "aws_ecs_service" "example" {
  name    = "example"
  cluster = aws_ecs_cluster.ecs_cluster.id

  alarms {
    enable   = true
    rollback = true
    alarm_names = [
      aws_cloudwatch_metric_alarm.example.alarm_name
    ]
  }
}
