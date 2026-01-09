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
  description = "Lambda configuration for the Cognito User Pool (if configured)"
  value       = var.post_confirmation_lambda_arn != "" ? aws_cognito_user_pool.this.lambda_config : null
}

output "deletion_protection" {
  description = "Deletion protection status of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.deletion_protection
}

# ==============================================================================
# ALB AUTHENTICATION OUTPUTS
# ==============================================================================

output "user_pool_client_id" {
  description = "ID of the Cognito User Pool Client for ALB authentication"
  value       = var.enable_alb_authentication ? aws_cognito_user_pool_client.alb_client[0].id : null
}

output "user_pool_client_secret" {
  description = "Secret of the Cognito User Pool Client for ALB authentication"
  value       = var.enable_alb_authentication ? aws_cognito_user_pool_client.alb_client[0].client_secret : null
  sensitive   = true
}

output "user_pool_domain" {
  description = "Domain of the Cognito User Pool for ALB authentication"
  value       = var.enable_alb_authentication && var.user_pool_domain != "" ? aws_cognito_user_pool_domain.alb_domain[0].domain : null
}

output "user_pool_domain_hosted_zone_id" {
  description = "Hosted Zone ID of the Cognito User Pool Domain"
  value       = var.enable_alb_authentication && var.user_pool_domain != "" ? aws_cognito_user_pool_domain.alb_domain[0].cloudfront_distribution_zone_id : null
}

output "user_pool_endpoint" {
  description = "Endpoint name of the Cognito User Pool"
  value       = aws_cognito_user_pool.this.endpoint
}