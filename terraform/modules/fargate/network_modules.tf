module "network" {
  source = "../network"

  name                       = var.name
  region                     = var.region
  vpc_cidr                   = var.vpc_cidr
  create_nat_gateway         = var.create_nat_gateway
  db_name                    = var.db_name
  db_username                = var.db_username
  db_password                = var.db_password
  skip_final_snapshot        = var.skip_final_snapshot
  environment                = var.environment
  internal                   = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  domain_name                = var.domain_name
  domain_prefix_alb          = var.domain_prefix_alb
  domain_prefix_cloudfront   = var.domain_prefix_cloudfront
  frontend_bucket_name       = var.frontend_bucket_name
}
