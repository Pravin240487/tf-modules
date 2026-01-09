# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "cognito_user_pool_name" {
  description = "The name of the Cognito User Pool"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Cognito User Pool"
  type        = map(string)
}

# ==============================================================================
# SECURITY CONFIGURATION
# ==============================================================================

variable "advanced_security_mode" {
  description = "Advanced security mode for the Cognito User Pool (OFF, AUDIT, ENFORCED)"
  type        = string
  default     = "OFF"
}

variable "deletion_protection" {
  description = "Deletion protection for the Cognito User Pool (ACTIVE or INACTIVE)"
  type        = string
  default     = "ACTIVE"
}

# ==============================================================================
# PRIMARY ATTRIBUTE SCHEMA
# ==============================================================================

variable "attribute_data_type" {
  description = "Data type of the primary user pool attribute"
  type        = string
  default     = "String"
}

variable "name" {
  description = "Name of the primary user pool attribute (typically 'email')"
  type        = string
  default     = "email"
}

variable "required" {
  description = "Whether the primary user pool attribute is required for user registration"
  type        = bool
  default     = true
}

variable "mutable" {
  description = "Whether the primary user pool attribute can be changed after user creation"
  type        = bool
  default     = false
}

# ==============================================================================
# ADDITIONAL SCHEMA CONFIGURATION
# ==============================================================================

variable "user_pool_schemas" {
  description = "List of additional custom user pool attributes (schema)"
  type = list(object({
    attribute_data_type = string
    name                = string
    required            = bool
    mutable             = bool
    string_attribute_constraints = optional(object({
      min_length = number
      max_length = number
    }))
  }))
  default = []

}

# ==============================================================================
# LAMBDA INTEGRATION
# ==============================================================================

variable "post_confirmation_lambda_arn" {
  description = "ARN of the Lambda function to invoke after user confirmation (optional)"
  type        = string
  default     = ""
}

# ==============================================================================
# ALB AUTHENTICATION CONFIGURATION
# ==============================================================================

variable "enable_alb_authentication" {
  description = "Enable Cognito User Pool Client for ALB authentication"
  type        = bool
  default     = false
}

variable "callback_urls" {
  description = "List of allowed callback URLs for ALB authentication"
  type        = list(string)
  default     = []
}

variable "logout_urls" {
  description = "List of allowed logout URLs for ALB authentication"
  type        = list(string)
  default     = []
}

variable "user_pool_domain" {
  description = "Domain for Cognito User Pool (required for ALB authentication)"
  type        = string
  default     = ""
}

variable "alb_client_identity_providers" {
  description = "List of supported identity providers for ALB authentication client"
  type        = list(string)
  default     = ["COGNITO"]
}

# ==============================================================================
# USER POOL ATTRIBUTES
# ==============================================================================

variable "auto_verified_attributes" {
  description = "Attributes to be auto-verified (email, phone_number)"
  type        = list(string)
  default     = ["email"]
}

variable "username_attributes" {
  description = "Attributes used for username (email, phone_number)"
  type        = list(string)
  default     = ["email"]
}

variable "alias_attributes" {
  description = "Attributes supported as an alias for this user pool (not used when username_attributes is set)"
  type        = list(string)
  default     = []
}

# ==============================================================================
# PASSWORD POLICY CONFIGURATION
# ==============================================================================

variable "password_minimum_length" {
  description = "Minimum length of the password policy"
  type        = number
  default     = 12
}

variable "password_require_lowercase" {
  description = "Whether to require lowercase characters"
  type        = bool
  default     = true
}

variable "password_require_numbers" {
  description = "Whether to require numbers"
  type        = bool
  default     = true
}

variable "password_require_symbols" {
  description = "Whether to require symbols"
  type        = bool
  default     = true
}

variable "password_require_uppercase" {
  description = "Whether to require uppercase characters"
  type        = bool
  default     = true
}

# ==============================================================================
# ACCOUNT RECOVERY CONFIGURATION
# ==============================================================================

variable "recovery_mechanisms" {
  description = "List of recovery mechanisms for account recovery"
  type = list(object({
    name     = string
    priority = number
  }))
  default = [
    {
      name     = "verified_email"
      priority = 1
    }
  ]
}

# ==============================================================================
# TOKEN VALIDITY CONFIGURATION
# ==============================================================================

variable "access_token_validity" {
  description = "Time limit for access token validity"
  type        = number
  default     = 24
}

variable "id_token_validity" {
  description = "Time limit for ID token validity"
  type        = number
  default     = 24
}

variable "refresh_token_validity" {
  description = "Time limit for refresh token validity"
  type        = number
  default     = 30
}

variable "token_validity_units" {
  description = "Token validity units configuration"
  type = object({
    access_token  = string
    id_token      = string
    refresh_token = string
  })
  default = {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "days"
  }
}