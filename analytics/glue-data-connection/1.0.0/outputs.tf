output "arn" {
  description = "ARN of the Glue connection"
  value       = aws_glue_connection.this.arn
}

output "id" {
  description = "ID of the Glue connection"
  value       = aws_glue_connection.this.id
}