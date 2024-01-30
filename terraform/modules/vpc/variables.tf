#####################
#       COMMON      #
#####################
variable "name" {
  type = string
}

variable "public" {
  type = bool
}
#####################
#       VPC         #
#####################
variable "vpc_cidr" {
  type = string
}
