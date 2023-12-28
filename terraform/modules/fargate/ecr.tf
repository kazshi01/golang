data "aws_ecr_repository" "existing" {
  name = var.ecr_name
}

locals {
  ecr_image = "${data.aws_ecr_repository.existing.repository_url}:${var.image_tag}"
}

# ----------------------------------------------------------
# Null Resource
# ----------------------------------------------------------
resource "null_resource" "frontend" {
  triggers = {
    // MD5 チェックし、トリガーにする
    file_content_md5 = md5(file("${path.module}/fluentbit/dockerbuild.sh"))
  }

  provisioner "local-exec" {
    // ローカルのスクリプトを呼び出す
    command = "sh ${path.module}/fluentbit/dockerbuild.sh"

    // スクリプト専用の環境変数
    environment = {
      AWS_REGION     = var.region
      AWS_ACCOUNT_ID = local.account_id
      REPO_URL       = data.aws_ecr_repository.existing.repository_url
      CONTAINER_NAME = "fluentbit"
    }
  }
}
