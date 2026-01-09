output "name" {
  description = "Name of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.this.name
}

output "id" {
  description = "ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.this.id
}

output "client_id" {
  description = "Client ID of the Cognito User Pool Client"
  value       = aws_cognito_user_pool_client.this.id
}

output "user_pool_id" {
  description = "ID of the Cognito User Pool"
  value       = aws_cognito_user_pool_client.this.user_pool_id
}

output "client_secret" {
  description = "Client secret of the Cognito User Pool Client (only available when generate_secret is true)"
  value       = try(aws_cognito_user_pool_client.this.client_secret, null)
  sensitive   = true
}