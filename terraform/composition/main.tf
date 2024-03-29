module "React_Golang_Application" {
  source = "../foundations"

  name                       = var.name
  region                     = var.region
  public                     = var.public
  vpc_cidr                   = var.vpc_cidr
  db_name                    = var.db_name
  db_username                = var.db_username
  skip_final_snapshot        = var.skip_final_snapshot
  environment                = var.environment
  internal                   = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  domain_name                = var.domain_name
  domain_prefix_alb          = var.domain_prefix_alb
  domain_prefix_cloudfront   = var.domain_prefix_cloudfront
  s3_bucket_name             = var.s3_bucket_name
  frontend_bucket_name       = var.frontend_bucket_name
  container_name             = var.container_name
  hostPort                   = var.hostPort
  containerPort              = var.containerPort
  assign_public_ip           = var.assign_public_ip
  ecr_name                   = var.ecr_name
  image_tag                  = var.image_tag

}
