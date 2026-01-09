output "secret_arn" {
  description = "ARN of the secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_id" {
  description = "ID of the secret"
  value       = aws_secretsmanager_secret.this.id
}

output "secret_name" {
  description = "The name of the created Secrets Manager secret."
  value       = aws_secretsmanager_secret.this.name
}