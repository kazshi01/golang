## Service
resource "aws_security_group" "service_sg" {
  name        = "${var.name}-service-sg"
  description = "Security group for the Service"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "Target Group from ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [module.network.alb_sg]
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

## RDS
resource "aws_security_group_rule" "default_to_postgres_sg_ingress" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = module.network.postgres_sg_id
  source_security_group_id = aws_security_group.service_sg.id
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
