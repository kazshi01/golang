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
#       ALB         #
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
variable "frontend_bucket_name" {
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
#      SUBNET       #
#####################
variable "public_subnet_ids" {
  type = list(string)
}
