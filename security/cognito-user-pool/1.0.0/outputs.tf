output "name" {
  description = "Name of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.name
}

output "arn" {
  description = "ARN of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.arn
}

output "id" {
  description = "ID of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_add_ons" {
  description = "User Pool Add-Ons configuration"
  value       = aws_cognito_user_pool.this.user_pool_add_ons
}

output "lambda_config" {
  description = "Lambda configuration for the Cognito User Pool"
  value       = aws_cognito_user_pool.this.lambda_config
}

output "deletion_protection" {
  description = "Deletion protection status of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.deletion_protection
}