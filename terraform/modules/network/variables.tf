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
#       ALB         #
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
