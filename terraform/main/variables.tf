variable "name" {
  type    = string
  default = "terraform"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

#####################
#       VPC         #
#####################
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

#####################
#    ROUTE_TABLE    #
#####################

variable "create_nat_gateway" {
  type    = bool
  default = false
}

#####################
#        RDS        #
#####################
variable "db_username" {
  type    = string
  default = "marukome"
}

variable "db_password" {
  type    = string
  default = "marukome"
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

#####################
#        ALB        #
#####################

variable "environment" {
  type    = string
  default = "dev"
}

variable "internal" {
  type    = bool
  default = false
}

variable "enable_deletion_protection" {
  type    = bool
  default = false

}

#####################
#      ROUTE53      #
#####################

variable "domain_name" {
  type    = string
  default = "marukome0909.com"
}
variable "domain_prefix_alb" {
  type    = string
  default = "alb"
}

#####################
#     CROUDFRONT    #
#####################
variable "domain_prefix_cloudfront" {
  type    = string
  default = "cloudfront"
}

#####################
#      SERVICE      #
#####################
variable "container_name" {
  type    = string
  default = "go"
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "assign_public_ip" {
  type    = bool
  default = true
}

#####################
#        ECR        #
#####################
variable "ecr_name" {
  type    = string
  default = "dev/practice"
}

variable "image_tag" {
  type    = string
  default = "go-9"
}
