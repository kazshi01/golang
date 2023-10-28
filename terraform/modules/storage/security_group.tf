resource "aws_security_group" "efs_sg" {
  name        = "${var.name}-efs-sg"
  description = "Security group for the EFS"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-efs-sg"
  }
}
