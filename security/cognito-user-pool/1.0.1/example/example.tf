# ==============================================================================
# AWS Cognito User Pool Examples
# ==============================================================================

# ==============================================================================
# Example 1: Basic User Pool without Lambda
# ==============================================================================
module "basic_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"

  cognito_user_pool_name = "basic-user-pool"
  advanced_security_mode = "AUDIT"
  deletion_protection    = "INACTIVE"

  # Primary email attribute
  attribute_data_type = "String"
  name                = "email"
  required            = true
  mutable             = false

  # No Lambda configuration needed
  post_confirmation_lambda_arn = ""

  tags = {
    Environment = "development"
    Service     = "authentication"
  }
}

# ==============================================================================
# Example 2: User Pool with Lambda Post-Confirmation Trigger
# ==============================================================================
module "user_pool_with_lambda" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"

  cognito_user_pool_name = "lambda-enabled-user-pool"
  advanced_security_mode = "ENFORCED"
  deletion_protection    = "ACTIVE"

  # Primary email attribute
  attribute_data_type = "String"
  name                = "email"
  required            = true
  mutable             = false

  # Lambda post-confirmation trigger
  post_confirmation_lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:user-post-confirmation"

  tags = {
    Environment = "production"
    Service     = "authentication"
  }
}

# ==============================================================================
# Example 3: User Pool with Custom Attributes
# ==============================================================================
module "custom_attributes_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"

  cognito_user_pool_name = "custom-attrs-user-pool"
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
      name                = "object_id"
      required            = false
      mutable             = true
      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    },
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
    }
  ]

  post_confirmation_lambda_arn = ""

  tags = {
    Environment = "production"
    Service     = "authentication"
  }
}

# ==============================================================================
# Example 4: User Pool with ALB Authentication
# ==============================================================================
module "alb_auth_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"

  cognito_user_pool_name = "alb-auth-user-pool"
  advanced_security_mode = "ENFORCED"
  deletion_protection    = "ACTIVE"

  # Primary email attribute
  attribute_data_type = "String"
  name                = "email"
  required            = true
  mutable             = false

  # ALB Authentication Configuration
  enable_alb_authentication = true
  user_pool_domain          = "my-app-auth-domain"
  callback_urls             = ["https://my-app.example.com/oauth2/idpresponse"]
  logout_urls               = ["https://my-app.example.com/logout"]

  # Token validity settings
  access_token_validity  = 24  # hours
  id_token_validity      = 24  # hours
  refresh_token_validity = 30  # days

  post_confirmation_lambda_arn = ""

  tags = {
    Environment = "production"
    Service     = "authentication"
    ALB         = "enabled"
  }
}

# ==============================================================================
# Example 5: Complete Configuration with All Features
# ==============================================================================
module "complete_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"

  cognito_user_pool_name = "complete-user-pool"
  advanced_security_mode = "ENFORCED"
  deletion_protection    = "ACTIVE"

  # Primary email attribute
  attribute_data_type = "String"
  name                = "email"
  required            = true
  mutable             = false

  # Custom attributes
  user_pool_schemas = [
    {
      attribute_data_type = "String"
      name                = "object_id"
      required            = false
      mutable             = true
      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    }
  ]

  # Lambda integration
  post_confirmation_lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:post-confirmation"

  # ALB Authentication
  enable_alb_authentication = true
  user_pool_domain          = "complete-app-auth"
  callback_urls             = ["https://app.example.com/oauth2/idpresponse"]
  logout_urls               = ["https://app.example.com/logout"]

  # Password policy
  password_minimum_length    = 12
  password_require_lowercase = true
  password_require_uppercase = true
  password_require_numbers   = true
  password_require_symbols   = true

  # Account recovery
  recovery_mechanisms = [
    {
      name     = "verified_email"
      priority = 1
    }
  ]

  # Token configuration
  access_token_validity  = 12  # hours
  id_token_validity      = 12  # hours
  refresh_token_validity = 7   # days

  tags = {
    Environment         = "production"
    Service            = "authentication"
    SecurityCompliance = "enforced"
    ALB                = "enabled"
    BackupRequired     = "true"
  }
}

# ==============================================================================
# Usage with ALB Listener Rule
# ==============================================================================
# Example of how to use the Cognito User Pool with ALB
# resource "aws_lb_listener_rule" "cognito_auth" {
#   listener_arn = aws_lb_listener.https.arn
#   priority     = 100
#
#   action {
#     type = "authenticate-cognito"
#     authenticate_cognito {
#       user_pool_arn       = module.alb_auth_user_pool.arn
#       user_pool_client_id = module.alb_auth_user_pool.user_pool_client_id
#       user_pool_domain    = module.alb_auth_user_pool.user_pool_domain
#     }
#   }
#
#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app.arn
#   }
#
#   condition {
#     path_pattern {
#       values = ["/protected/*"]
#     }
#   }
# }
