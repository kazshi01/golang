## Module storage
output "vpc_id" {
  value = module.storage.vpc_id
}
output "public_subnet_ids" {
  value = module.storage.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.storage.private_subnet_ids
}
output "postgres_sg_id" {
  value = module.storage.postgres_sg_id
}

output "postgres_endpoint" {
  value = module.storage.postgres_endpoint
}

output "efs_id" {
  value = module.storage.efs_id
}

output "access_point_id" {
  value = module.storage.access_point_id
}

output "efs_sg_id" {
  value = module.storage.efs_sg_id
}

## ALB
output "alb_sg" {
  value = aws_security_group.alb_sg.id
}
output "target_group_arn" {
  value = aws_lb_target_group.target_ip.arn
}
