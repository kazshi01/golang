resource "aws_security_group" "service_sg" {
  name        = "${var.name}-service-sg"
  description = "FarGate Service Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "TLS from VPC"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [module.network.alb_security_group_id]
  }

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
