resource "aws_efs_file_system" "efs" {
  creation_token = "terraform-product"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name = "${var.name}-efs"
  }
}

resource "aws_efs_access_point" "access_point" {
  file_system_id = aws_efs_file_system.efs.id

  posix_user {
    gid = 1000
    uid = 1000
  }
}

resource "aws_efs_mount_target" "mount_target" {
  count           = length(module.vpc.public_subnet_ids)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = module.vpc.public_subnet_ids[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}
