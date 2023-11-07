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
    description = "SSM Agent for execution-command"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [module.network.cloud9_sg_id] #運用監視サーバ(cloud9)等の信頼できるIPアドレス範囲を指定
  }

  ingress {
    description     = "PostgreSQL from RDS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.network.postgres_sg_id]
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
