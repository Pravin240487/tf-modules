output "name" {
  description = "The name of the RDS subnet group"
  value       = aws_db_subnet_group.this.name
}

output "arn" {
  description = "The ARN of the RDS subnet group"
  value       = aws_db_subnet_group.this.arn
}

output "id" {
  description = "The ID of the RDS subnet group"
  value       = aws_db_subnet_group.this.id
}

output "subnet_ids" {
  description = "The list of subnet IDs in the RDS subnet group"
  value       = aws_db_subnet_group.this.subnet_ids
}