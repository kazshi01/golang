resource "aws_cloud9_environment_ec2" "cloud9" {
  name                        = "${var.name}-cloud9"
  instance_type               = "t2.micro"
  automatic_stop_time_minutes = 30
  subnet_id                   = aws_subnet.public_subnets[0].id
}
