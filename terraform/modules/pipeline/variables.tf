#####################
#      COMMON       #
#####################
variable "name" {
  type = string
}

variable "region" {
  type = string
}

#####################
#      SERVICE      #
#####################
variable "container_name" {
  type = string
}

variable "containerPort" {
  type = number
}

############################################
#          modify階層で指定する変数           #
############################################

#####################
#       ECS         #
#####################
variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}
variable "task_definition_arn" {
  type = string
}

#####################
#       ALB         #
#####################
variable "bule_target_group_name" {
  type = string
}

variable "green_target_group_name" {
  type = string
}

variable "https_listener_arn" {
  type = string
}
