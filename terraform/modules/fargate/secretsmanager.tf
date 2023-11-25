## DATABASE_PASSWORD
data "aws_secretsmanager_secret" "postgres_password" {
  name = "postgres_password"
}

data "aws_secretsmanager_secret_version" "postgres_password" {
  secret_id = "postgres_password"
}

locals {
  db_password = jsondecode(data.aws_secretsmanager_secret_version.postgres_password.secret_string)["DATABASE_PASSWORD"]
}

## SECRET
data "aws_secretsmanager_secret" "go_app_secret" {
  name = "go_app_secret"
}

data "aws_secretsmanager_secret_version" "go_app_secret" {
  secret_id = "go_app_secret"
}

locals {
  secret = jsondecode(data.aws_secretsmanager_secret_version.go_app_secret.secret_string)["SECRET"]
}
