module "network" {
  source = "../network"

  name                       = var.name
  region                     = var.region
  vpc_cidr                   = var.vpc_cidr
  create_nat_gateway         = var.create_nat_gateway
  environment                = var.environment
  internal                   = var.internal
  enable_deletion_protection = var.enable_deletion_protection

}
