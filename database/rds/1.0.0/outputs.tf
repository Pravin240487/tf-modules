output "name" {
  description = "The name of the RDS instance"
  value       = aws_db_instance.this.id
}

output "arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "db_name" {
  description = "The name of the database created within the RDS instance"
  value       = aws_db_instance.this.db_name
}

output "parameter_group_name" {
  description = "Name of the RDS Parameter Group"
  value       = aws_db_parameter_group.this.name
}

output "parameter_group_family" {
  description = "Family of the RDS Parameter Group"
  value       = aws_db_parameter_group.this.family
}

output "parameter_group_arn" {
  description = "ARN of the RDS Parameter Group"
  value       = aws_db_parameter_group.this.arn
}

output "id" {
  description = "ID of the RDS Parameter Group"
  value       = aws_db_parameter_group.this.id
}
