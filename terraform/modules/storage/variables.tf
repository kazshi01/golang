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
variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}
