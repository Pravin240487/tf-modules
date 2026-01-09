# ==============================================================================
# AWS Cognito User Pool Domain
# ==============================================================================
# Creates a domain for the Cognito User Pool to enable the hosted UI
# Provides a custom domain for authentication flows and user management pages
# Supports both Amazon Cognito domain and custom domain configurations

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.domain
  user_pool_id = var.user_pool_id
}