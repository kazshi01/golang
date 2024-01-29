#####################
#       COMMON      #
#####################
variable "name" {
  type = string
}

variable "region" {
  type = string
}

#####################
#       VPC         #
#####################
variable "vpc_cidr" {
  type = string
}

#####################
#    ROUTE_TABLE    #
#####################

variable "create_nat_gateway" {
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
variable "skip_final_snapshot" {
  type = bool
}

#####################
#        ALB        #
#####################

variable "environment" {
  type = string
}

variable "internal" {
  type = bool
}

variable "enable_deletion_protection" {
  type = bool
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

variable "assign_public_ip" {
  type = bool
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
