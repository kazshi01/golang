variable "name" {
  type    = string
  default = "terraform"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
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
