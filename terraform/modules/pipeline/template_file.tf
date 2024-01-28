data "template_file" "appspec" {
  template = file("../modules/pipeline/appspec.yml.tmpl")

  vars = {
    task_definition_arn = var.task_definition_arn
    container_name      = var.container_name
    container_port      = var.containerPort
  }
}

# appspec.ymlを任意の場所に配置する（Github Actionsで　CodeDeployが参照するファイルの場所を指定する）
resource "local_file" "appspec" {
  content  = data.template_file.appspec.rendered
  filename = "${path.module}/appspec.yml"
}
