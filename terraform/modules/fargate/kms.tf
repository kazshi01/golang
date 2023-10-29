resource "aws_kms_key" "cloudwatch_logs_key" {
  description = "KMS key for CloudWatch Logs"
  policy      = data.aws_iam_policy_document.cloudwatch_logs_key_policy.json
}

data "aws_iam_policy_document" "cloudwatch_logs_key_policy" {
  # AWSアカウントへのアクセスを許可する
  statement {
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:user/Administrator"]
    }
  }

  # CloudWatch Logsへのアクセスを許可する
  statement {
    actions   = ["kms:Encrypt", "kms:Decrypt", "kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:DescribeKey"]
    resources = ["*"]
    principals {
      type        = "Service"
      identifiers = ["logs.ap-northeast-1.amazonaws.com"]
    }
    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:ap-northeast-1:${local.account_id}:*"]
    }
  }

  # ECS Execコマンド用の権限を付与する
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:role/ecs-task-role"]
    }
  }
}
