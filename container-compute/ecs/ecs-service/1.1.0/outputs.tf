output "arn" {
  description = "value of the ECS service ARN"
  value       = aws_ecs_service.this.id
}

output "ecs_security_group_id" {
  value = module.aws_security_group.id
}