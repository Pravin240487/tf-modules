output "arn" {
  description = "The ARN of the ECS task definition."
  value       = aws_ecs_task_definition.this.arn
}

output "revision" {
  description = "The revision number of the ECS task definition."
  value       = aws_ecs_task_definition.this.revision
}

output "arn_without_revision" {
  description = "The ARN of the ECS task definition without the revision number."
  value       = aws_ecs_task_definition.this.arn_without_revision
}