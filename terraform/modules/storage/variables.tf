#####################
#      COMMON       #
#####################
variable "name" {
  type = string
}

#####################
#        RDS        #
#####################
variable "db_name" {
  type = string
}
variable "db_username" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

############################################
#          modify階層で指定する変数           #
############################################

#####################
#       VPC         #
#####################
variable "vpc_id" {
  type = string
}

#####################
#       SUBNET      #
#####################
variable "public_subnet_ids" {
  type = list(string)
}
variable "database_subnet_ids" {
  type = list(string)
}
