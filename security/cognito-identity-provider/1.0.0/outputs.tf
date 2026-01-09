output "provider_name" {
  description = "Name of the Cognito Identity Provider"
  value       = aws_cognito_identity_provider.this.provider_name
}

output "provider_type" {
  description = "Type of the Cognito Identity Provider"
  value       = aws_cognito_identity_provider.this.provider_type
}

output "user_pool_id" {
  description = "ID of the Cognito User Pool"
  value       = aws_cognito_identity_provider.this.user_pool_id
}