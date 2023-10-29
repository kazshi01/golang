resource "aws_kms_key" "cloudwatch_logs_key" {
  description = "KMS key for CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "Enable IAM User Permissions",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::996109426400:user/Administrator"
        },
        Action   = "kms:*",
        Resource = "*"
      },
      {
        Sid    = "Allow CloudWatch Logs to use the key",
        Effect = "Allow",
        Principal = {
          Service = "logs.ap-northeast-1.amazonaws.com"
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*",
        Condition = {
          ArnEquals = {
            "kms:EncryptionContext:aws:logs:arn" : "arn:aws:logs:ap-northeast-1:996109426400:*"
          }
        }
      },
      {
        Sid    = "Allow ECS Task Role to use the key",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::996109426400:role/ecs-task-role"
        },
        Action = [
          "kms:Decrypt"
        ],
        Resource = "arn:aws:kms:ap-northeast-1:996109426400:key/0d34acaa-6728-4224-bfb8-25484e7a345f"
      }
    ]
  })
}
