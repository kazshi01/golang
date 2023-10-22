#####################
#       VPC         #
#####################

variable "name" {
  type    = string
  default = "terraform"
}

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
