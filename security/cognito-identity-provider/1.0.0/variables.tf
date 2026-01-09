# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "user_pool_id" {
  description = "The ID of the Cognito User Pool to associate with the identity provider"
  type        = string
}

variable "provider_name" {
  description = "The name of the identity provider. Must be unique within the user pool"
  type        = string
}

variable "provider_type" {
  description = "The type of identity provider (SAML or OIDC)"
  type        = string
}

variable "metadata_url" {
  description = "The URL of the SAML metadata document or OIDC discovery endpoint"
  type        = string
}

# ==============================================================================
# OPTIONAL VARIABLES
# ==============================================================================

variable "idp_signout" {
  description = "Whether to enable identity provider initiated sign-out"
  type        = bool
}

variable "idp_attributes" {
  description = "Mapping of user attributes from the identity provider to Cognito User Pool attributes"
  type        = map(string)
  default = {
    email              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
    given_name         = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
    name               = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
    family_name        = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
    "custom:object_id" = "objectid"
  }
}