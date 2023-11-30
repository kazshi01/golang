output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.ecs_service.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.task_definition.arn
}

output "bule_target_group_name" {
  value = module.network.bule_target_group_name
}

output "green_target_group_name" {
  value = module.network.green_target_group_name
}

output "https_listener_arn" {
  value = module.network.https_listener_arn
}
