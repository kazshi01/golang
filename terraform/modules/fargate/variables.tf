variable "name" {
  type    = string
  default = "terraform"
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
