variable "name" {
  type    = string
  default = "terraform"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "internal" {
  type    = bool
  default = false
}

variable "enable_deletion_protection" {
  type    = bool
  default = false

}
