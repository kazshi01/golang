data "aws_ecr_repository" "existing" {
  name = var.ecr_name
}

locals {
  ecr_image = "${data.aws_ecr_repository.existing.repository_url}:${var.image_tag}"
}

