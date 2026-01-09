# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "app_client_name" {
  description = "The name of the Cognito User Pool Client"
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool to associate with this client"
  type        = string
}

variable "callbackUrls" {
  description = "List of allowed callback URLs for OAuth flows"
  type        = list(string)
}

variable "logout_urls" {
  description = "List of allowed logout URLs for OAuth flows"
  type        = list(string)
}

variable "supported_identity_providers" {
  description = "List of supported identity providers for the client (COGNITO, and external providers)"
  type        = list(string)
}

# ==============================================================================
# CLIENT CONFIGURATION
# ==============================================================================

variable "generate_secret" {
  description = "Whether to generate a client secret. Set to false for public clients (mobile apps, SPAs)"
  type        = bool
  default     = true
}

variable "explicit_auth_flows" {
  description = "List of authentication flows allowed for this client"
  type        = list(string)
  default     = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
}

variable "prevent_user_existence_errors" {
  description = "Choose which errors and responses are returned by Cognito APIs during authentication"
  type        = string
  default     = "ENABLED"
}

# ==============================================================================
# TOKEN VALIDITY CONFIGURATION
# ==============================================================================

variable "token_validity_units" {
  description = "Configuration for token validity time units (days, hours, minutes)"
  type = object({
    refresh_token = string
    access_token  = string
    id_token      = string
  })
  default = {
    refresh_token = "days"
    access_token  = "days"
    id_token      = "days"
  }
}

variable "refresh_token_validity" {
  description = "Refresh token validity period in the specified units"
  type        = number
  default     = 1
}

variable "access_token_validity" {
  description = "Access token validity period in the specified units"
  type        = number
  default     = 1
}

variable "id_token_validity" {
  description = "ID token validity period in the specified units"
  type        = number
  default     = 1
}

# ==============================================================================
# OAUTH CONFIGURATION
# ==============================================================================

variable "allowed_oauth_flows_user_pool_client" {
  description = "Whether OAuth flows are enabled for this user pool client"
  type        = bool
  default     = true
}

variable "allowed_oauth_flows" {
  description = "List of allowed OAuth flows for this client"
  type        = list(string)
  default     = ["code"]
}

variable "allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes for this client"
  type        = list(string)
  default     = ["email", "openid", "phone", "profile", "aws.cognito.signin.user.admin"]
}