module "fargate" {
  source = "../modules/fargate"

  name                       = var.name
  region                     = var.region
  vpc_cidr                   = var.vpc_cidr
  create_nat_gateway         = var.create_nat_gateway
  environment                = var.environment
  internal                   = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  container_name             = var.container_name
  container_port             = var.container_port
  assign_public_ip           = var.assign_public_ip
  ecr_name                   = var.ecr_name
  image_tag                  = var.image_tag

}
