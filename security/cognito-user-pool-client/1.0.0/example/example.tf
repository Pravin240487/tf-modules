# ==============================================================================
# AWS Cognito User Pool Client Examples
# ==============================================================================

module "web_app_client" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool-client/1.0.0"

  app_client_name              = "production-web-app-client"
  user_pool_id                 = "us-east-1_ABC123DEF"
  callbackUrls                 = ["https://app.company.com/auth/callback"]
  logout_urls                  = ["https://app.company.com/auth/logout"]
  supported_identity_providers = ["COGNITO", "AzureAD", "Google"]

  # Server-side configuration with client secret
  generate_secret = true
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]

  # Production token validity settings
  token_validity_units = {
    refresh_token = "days"
    access_token  = "days"
    id_token      = "days"
  }

  refresh_token_validity = 30  # 30 days
  access_token_validity  = 1   # 1 day
  id_token_validity      = 1   # 1 day

  # Security settings
  prevent_user_existence_errors = "ENABLED"

  # OAuth configuration for authorization code flow
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "phone", "profile"]
}