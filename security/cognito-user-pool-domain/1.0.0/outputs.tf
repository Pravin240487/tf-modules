output "domain" {
  description = "The domain name for the Cognito User Pool"
  value       = aws_cognito_user_pool_domain.this.domain
}

output "user_pool_id" {
  description = "The ID of the Cognito User Pool"
  value       = aws_cognito_user_pool_domain.this.user_pool_id
}