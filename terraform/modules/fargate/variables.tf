#####################
#       COMMON      #
#####################
variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "public" {
  type = bool
}

#####################
#        RDS        #
#####################
variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}

#####################
#      ROUTE53      #
#####################

variable "domain_name" {
  type = string
}
variable "domain_prefix_alb" {
  type = string
}

#####################
#     CROUDFRONT    #
#####################
variable "domain_prefix_cloudfront" {
  type = string
}

#####################
#        S3         #
#####################

variable "s3_bucket_name" {
  type = string
}
variable "frontend_bucket_name" {
  type = string
}

#####################
#      SERVICE      #
#####################
variable "container_name" {
  type = string
}

variable "hostPort" {
  type = number
}

variable "containerPort" {
  type = number
}

#####################
#        ECR        #
#####################
variable "ecr_name" {
  type = string
}

variable "image_tag" {
  type = string
}

############################################
#          modify階層で指定する変数           #
############################################

#####################
#       VPC         #
#####################
variable "vpc_id" {
  type = string
}

#####################
#   SECURITY GROUP  #
#####################

variable "alb_sg" {
  type = string
}

variable "efs_sg_id" {
  type = string
}

variable "postgres_sg_id" {
  type = string
}

#####################
#      SUBNET       #
#####################
variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

#####################
#   TARGET GROUP    #
#####################
variable "bule_target_group_arn" {
  type = string
}

#####################
#     POSTGRES      #
#####################
variable "postgres_endpoint" {
  type = string
}

#####################
#        EFS        #
#####################
variable "efs_id" {
  type = string
}

variable "access_point_id" {
  type = string
}
