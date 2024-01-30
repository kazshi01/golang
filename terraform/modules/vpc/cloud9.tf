resource "aws_cloud9_environment_ec2" "cloud9" {
  name                        = "${var.name}-cloud9"
  instance_type               = "t2.micro"
  image_id                    = "amazonlinux-2-x86_64"
  automatic_stop_time_minutes = 30
  subnet_id                   = aws_subnet.public_subnets["1"].id
}
