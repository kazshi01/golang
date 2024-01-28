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
