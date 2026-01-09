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
  description = "ARN of the Lambda function to invoke after user confirmation"
  type        = string

}