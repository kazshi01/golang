## Service
resource "aws_security_group" "service_sg" {
  name        = "${var.name}-service-sg"
  description = "Security group for the Service"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [module.network.alb_sg]
  }

  # SSM エージェントが必要な場合は443ポートを追加（execution-command）
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "NFS from EFS"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [module.network.efs_sg_id]
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

## EFS
resource "aws_security_group_rule" "efs_sg_ingress" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = module.network.efs_sg_id
  source_security_group_id = aws_security_group.service_sg.id
}
