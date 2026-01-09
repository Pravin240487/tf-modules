output "name" {
  description = "The name of the Redis replication group."
  value       = aws_elasticache_replication_group.this.replication_group_id
}

output "arn" {
  description = "The ARN of the Redis replication group."
  value       = aws_elasticache_replication_group.this.arn
}

output "endpoint" {
  description = "The primary endpoint of the Redis replication group."
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
}

output "reader_endpoint" {
  description = "The reader endpoint of the Redis replication group."
  value       = aws_elasticache_replication_group.this.reader_endpoint_address
}