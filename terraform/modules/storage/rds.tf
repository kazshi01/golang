resource "aws_db_instance" "postgres" {
  identifier        = "${var.name}-postgres"
  allocated_storage = 10
  engine            = "postgres"
  engine_version    = "15.3"
  instance_class    = "db.t3.micro"
  db_name           = var.db_name
  username          = var.db_username
  password          = local.db_password
  # password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres.id
}

resource "aws_db_subnet_group" "postgres" {
  name       = "postgres-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}


