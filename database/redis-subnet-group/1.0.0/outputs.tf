output "name" {
  description = "The name of the Redis subnet group"
  value       = aws_elasticache_subnet_group.this.name
}

output "arn" {
  description = "The ARN of the Redis subnet group"
  value       = aws_elasticache_subnet_group.this.arn
}

output "subnet_ids" {
  description = "A list of subnet IDs for the Redis subnet group"
  value       = aws_elasticache_subnet_group.this.subnet_ids
}