resource "aws_security_group" "service_sg" {
  name        = "${var.name}-service-sg"
  description = "FarGate Service Security Group"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [module.network.alb_sg]
  }

  # ingress {
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-service-sg"
  }
}
