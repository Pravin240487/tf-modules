# ==============================================================================
# AWS Cognito Identity Provider
# ==============================================================================
# Creates a Cognito Identity Provider to enable federated authentication
# with external identity providers (SAML, OIDC) for Single Sign-On (SSO)

resource "aws_cognito_identity_provider" "this" {
  user_pool_id  = var.user_pool_id
  provider_name = var.provider_name
  provider_type = var.provider_type

  # Provider-specific configuration details
  # For SAML: MetadataURL, IDPSignout, SSORedirectBindingURI, etc.
  # For OIDC: client_id, client_secret, authorize_scopes, etc.
  provider_details = {
    "MetadataURL" : var.metadata_url
    "IDPSignout" : var.idp_signout
  }

  # Attribute mapping between external identity provider and Cognito User Pool
  # Maps external IDP attributes to Cognito user attributes
  attribute_mapping = var.idp_attributes
}