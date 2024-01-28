## ALB
output "alb_sg" {
  value = aws_security_group.alb_sg.id
}
output "https_listener_arn" {
  value = aws_lb_listener.https_listener.arn
}
output "bule_target_group_name" {
  value = aws_lb_target_group.blue_target_ip.name
}
output "bule_target_group_arn" {
  value = aws_lb_target_group.blue_target_ip.arn
}
output "green_target_group_name" {
  value = aws_lb_target_group.green_target_ip.name
}
