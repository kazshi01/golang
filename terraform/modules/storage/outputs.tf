## Module vpc
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

## RDS
output "postgres_sg_id" {
  value = aws_security_group.postgres_sg.id
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
