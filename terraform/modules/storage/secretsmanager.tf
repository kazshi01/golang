# Secrets Managerから秘密情報を取得
# data "aws_secretsmanager_secret" "db_password" {
#   name = "my_db_password_secret"
# }

# data "aws_secretsmanager_secret_version" "db_password" {
#   secret_id = data.aws_secretsmanager_secret.db_password.id
# }
