# ==============================================================================
# AWS Cognito Identity Provider Examples
# ==============================================================================

# Example 1: SAML Identity Provider (Azure AD)
module "azure_ad_saml_provider" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-identity-provider/1.0.0"

  user_pool_id  = "us-east-1_ABC123DEF"
  provider_name = "AzureAD"
  provider_type = "SAML"
  metadata_url  = "https://login.microsoftonline.com/tenant-id/federationmetadata/2007-06/federationmetadata.xml"
  idp_signout   = true

  idp_attributes = {
    email                    = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
    given_name              = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
    family_name             = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"
    name                    = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
    preferred_username      = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
    "custom:department"     = "http://schemas.microsoft.com/ws/2008/06/identity/claims/department"
    "custom:employee_id"    = "http://schemas.microsoft.com/identity/claims/objectidentifier"
  }
}