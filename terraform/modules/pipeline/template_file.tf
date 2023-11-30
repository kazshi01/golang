data "template_file" "appspec" {
  template = file("../modules/pipeline/appspec.yml.tmpl")

  vars = {
    task_definition_arn = module.fargate.task_definition_arn
    container_name      = var.container_name
    container_port      = var.containerPort
  }
}

resource "aws_s3_object" "appspec" {
  bucket  = var.s3_bucket_name
  key     = "codedeploy/appspec.yml"
  content = data.template_file.appspec.rendered
}
