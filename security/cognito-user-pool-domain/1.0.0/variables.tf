# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "domain" {
  description = "The domain name for the Cognito User Pool. For Amazon Cognito domain, use a unique name. For custom domain, use your own domain name."
  type        = string
}

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool to associate with the domain"
  type        = string
}
