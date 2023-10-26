resource "aws_cloudwatch_log_group" "container_log" {
  name = "/aws/ecs/log-group"
}
