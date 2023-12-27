resource "aws_cloudwatch_log_group" "container_log" {
  name = "/aws/ecs/log-group"
  # kms_key_id = aws_kms_key.cloudwatch_logs_key.arn
}
