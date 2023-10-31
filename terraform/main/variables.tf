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
#      SERVICE      #
#####################
variable "container_name" {
  type    = string
  default = "nginx"
}

variable "container_port" {
  type    = number
  default = 80
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
  default = "8"
}