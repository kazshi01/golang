module "vpc" {
  source = "../modules/vpc"

  name     = var.name
  public   = var.public
  vpc_cidr = var.vpc_cidr

}

module "storage" {
  source = "../modules/storage"

  name                = var.name
  public              = var.public
  db_name             = var.db_name
  db_username         = var.db_username
  skip_final_snapshot = var.skip_final_snapshot

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  database_subnet_ids = module.vpc.database_subnet_ids

}

module "network" {
  source = "../modules/network"

  name                       = var.name
  region                     = var.region
  environment                = var.environment
  internal                   = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  domain_name                = var.domain_name
  domain_prefix_alb          = var.domain_prefix_alb
  domain_prefix_cloudfront   = var.domain_prefix_cloudfront
  frontend_bucket_name       = var.frontend_bucket_name

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

}

module "fargate" {
  source = "../modules/fargate"

  name                     = var.name
  region                   = var.region
  public                   = var.public
  db_name                  = var.db_name
  db_username              = var.db_username
  domain_name              = var.domain_name
  domain_prefix_alb        = var.domain_prefix_alb
  domain_prefix_cloudfront = var.domain_prefix_cloudfront
  s3_bucket_name           = var.s3_bucket_name
  frontend_bucket_name     = var.frontend_bucket_name
  container_name           = var.container_name
  hostPort                 = var.hostPort
  containerPort            = var.containerPort
  ecr_name                 = var.ecr_name
  image_tag                = var.image_tag

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  postgres_sg_id    = module.storage.postgres_sg_id
  postgres_endpoint = module.storage.postgres_endpoint
  efs_id            = module.storage.efs_id
  access_point_id   = module.storage.access_point_id
  efs_sg_id         = module.storage.efs_sg_id

  alb_sg                = module.network.alb_sg
  bule_target_group_arn = module.network.bule_target_group_arn

}

# module "pipeline" {
#   source = "../modules/pipeline"

#   name           = var.name
#   region         = var.region
#   container_name = var.container_name
#   containerPort  = var.containerPort

#   ecs_cluster_name    = module.fargate.ecs_cluster_name
#   ecs_service_name    = module.fargate.ecs_service_name
#   task_definition_arn = module.fargate.task_definition_arn

#   bule_target_group_name  = module.network.bule_target_group_name
#   green_target_group_name = module.network.green_target_group_name
#   https_listener_arn      = module.network.https_listener_arn

# }
