output "id" {
  description = "value of the ECS cluster ID"
  value       = aws_ecs_cluster.this.id
}

output "arn" {
  description = "value of the ECS cluster ARN"
  value       = aws_ecs_cluster.this.arn
}