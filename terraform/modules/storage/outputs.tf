## RDS
output "postgres_sg_id" {
  value = aws_security_group.postgres_sg.id
}

output "postgres_endpoint" {
  value = split(":", aws_db_instance.postgres.endpoint)[0]
}

## EFS
output "efs_id" {
  value = aws_efs_file_system.efs.id
}

output "access_point_id" {
  value = aws_efs_access_point.access_point.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}
