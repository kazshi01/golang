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
