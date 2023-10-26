output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}
output "target_group_arn" {
  value = aws_lb_target_group.target_ip.arn
}
