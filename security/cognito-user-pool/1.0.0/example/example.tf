# ==============================================================================
# AWS Cognito User Pool Examples
# ==============================================================================

module "production_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.0"

  cognito_user_pool_name = "production-user-pool"
  advanced_security_mode = "ENFORCED"
  deletion_protection    = "ACTIVE"

  # Primary email attribute
  attribute_data_type = "String"
  name                = "email"
  required            = true
  mutable             = false

  # Custom business attributes
  user_pool_schemas = [
    {
      attribute_data_type = "String"
      name                = "custom:role"
      required            = false
      mutable             = true
      string_attribute_constraints = {
        min_length = 1
        max_length = 50
      }
    },
    {
      attribute_data_type = "String"
      name                = "custom:department"
      required            = false
      mutable             = true
      string_attribute_constraints = {
        min_length = 1
        max_length = 100
      }
    },
    {
      attribute_data_type = "String"
      name                = "custom:employee_id"
      required            = false
      mutable             = false
      string_attribute_constraints = {
        min_length = 5
        max_length = 20
      }
    }
  ]

  post_confirmation_lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:prod-user-post-confirmation"

  tags = {
    Environment         = "production"
    Service            = "authentication"
    SecurityCompliance = "enforced"
    BackupRequired     = "true"
  }
}