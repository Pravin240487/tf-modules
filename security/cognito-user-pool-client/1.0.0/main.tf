# ==============================================================================
# AWS Cognito User Pool Client
# ==============================================================================
# Creates a Cognito User Pool Client for application authentication
# Manages OAuth flows, token validity, and identity provider integration

resource "aws_cognito_user_pool_client" "this" {
  name         = var.app_client_name
  user_pool_id = var.user_pool_id

  # Client secret configuration for secure server-side applications
  # Set to false for public clients (mobile apps, SPAs)
  generate_secret = var.generate_secret

  # Authentication flow configuration
  # Defines which authentication methods are allowed for this client
  explicit_auth_flows = var.explicit_auth_flows

  # Token validity configuration with customizable time units
  # Supports days, hours, and minutes for different token types
  token_validity_units {
    refresh_token = var.token_validity_units.refresh_token
    access_token  = var.token_validity_units.access_token
    id_token      = var.token_validity_units.id_token
  }

  # Token lifetime configuration in specified units
  refresh_token_validity = var.refresh_token_validity
  access_token_validity  = var.access_token_validity
  id_token_validity      = var.id_token_validity

  # Security setting to prevent user enumeration attacks
  prevent_user_existence_errors = var.prevent_user_existence_errors

  # OAuth 2.0 and OpenID Connect configuration
  callback_urls                        = var.callbackUrls
  logout_urls                          = var.logout_urls
  allowed_oauth_flows_user_pool_client = var.allowed_oauth_flows_user_pool_client
  allowed_oauth_flows                  = var.allowed_oauth_flows
  allowed_oauth_scopes                 = var.allowed_oauth_scopes

  # Identity providers that can be used with this client
  # Can include COGNITO and external providers (SAML, OIDC)
  supported_identity_providers = var.supported_identity_providers
}