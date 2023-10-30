module "storage" {
  source = "../storage"

  name               = var.name
  region             = var.region
  vpc_cidr           = var.vpc_cidr
  create_nat_gateway = var.create_nat_gateway

}
