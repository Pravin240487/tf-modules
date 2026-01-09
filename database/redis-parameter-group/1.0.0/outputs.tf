output "name" {
  description = "The name of the Redis parameter group"
  value       = aws_elasticache_parameter_group.this.name
}

output "arn" {
  description = "The ARN of the Redis parameter group"
  value       = aws_elasticache_parameter_group.this.arn
}

output "family" {
  description = "The family of the Redis parameter group"
  value       = aws_elasticache_parameter_group.this.family
}