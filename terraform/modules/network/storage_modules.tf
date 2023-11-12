module "storage" {
  source = "../storage"

  name                = var.name
  region              = var.region
  vpc_cidr            = var.vpc_cidr
  create_nat_gateway  = var.create_nat_gateway
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  skip_final_snapshot = var.skip_final_snapshot

}
