# ==============================================================================
# AWS Cognito User Pool
# ==============================================================================
# Creates a Cognito User Pool for user authentication and management
# Supports custom attributes, Lambda triggers, and advanced security features

resource "aws_cognito_user_pool" "this" {
  name = var.cognito_user_pool_name

  # Advanced security features including risk-based authentication
  # and adaptive authentication capabilities
  user_pool_add_ons {
    advanced_security_mode = var.advanced_security_mode
  }

  # Primary user attribute schema (typically email for authentication)
  # This schema defines the main identifier for user accounts
  schema {
    attribute_data_type = var.attribute_data_type
    name                = var.name
    required            = var.required
    mutable             = var.mutable
  }

  # Additional custom user attributes schema
  # Supports dynamic schema definition for business-specific user data
  dynamic "schema" {
    for_each = var.user_pool_schemas != null ? var.user_pool_schemas : []
    content {
      attribute_data_type = schema.value.attribute_data_type
      name                = schema.value.name
      required            = schema.value.required
      mutable             = schema.value.mutable

      # String attribute constraints for data validation
      dynamic "string_attribute_constraints" {
        for_each = schema.value.string_attribute_constraints != null ? [1] : []
        content {
          min_length = schema.value.string_attribute_constraints.min_length
          max_length = schema.value.string_attribute_constraints.max_length
        }
      }
    }
  }

  # Lambda trigger configuration for custom authentication flows (optional)
  # Post-confirmation trigger executes after successful user verification
  dynamic "lambda_config" {
    for_each = var.post_confirmation_lambda_arn != "" ? [1] : []
    content {
      post_confirmation = var.post_confirmation_lambda_arn
    }
  }

  # ALB integration requires these settings
  auto_verified_attributes = var.auto_verified_attributes
  # Use either username_attributes OR alias_attributes, not both
  username_attributes      = var.username_attributes
  
  # Password policy for secure authentication
  password_policy {
    minimum_length    = var.password_minimum_length
    require_lowercase = var.password_require_lowercase
    require_numbers   = var.password_require_numbers
    require_symbols   = var.password_require_symbols
    require_uppercase = var.password_require_uppercase
  }

  # Account recovery settings
  account_recovery_setting {
    dynamic "recovery_mechanism" {
      for_each = var.recovery_mechanisms
      content {
        name     = recovery_mechanism.value.name
        priority = recovery_mechanism.value.priority
      }
    }
  }

  # Deletion protection to prevent accidental removal of user pool
  deletion_protection = var.deletion_protection
  
  tags = var.tags
}

# CloudWatch Log Group for each tenant
resource "aws_cloudwatch_log_group" "this" {
  name     = "/aws/cognito/${aws_cognito_user_pool.this.name}"

  retention_in_days = 90
  tags              = var.tags
}

# Cognito User Pool Client for ALB Authentication
resource "aws_cognito_user_pool_client" "alb_client" {
  count        = var.enable_alb_authentication ? 1 : 0
  name         = "${var.cognito_user_pool_name}-alb-client"
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  
  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls
  
  supported_identity_providers = var.alb_client_identity_providers

  # Token validity settings
  access_token_validity  = var.access_token_validity
  id_token_validity      = var.id_token_validity
  refresh_token_validity = var.refresh_token_validity

  token_validity_units {
    access_token  = var.token_validity_units.access_token
    id_token      = var.token_validity_units.id_token
    refresh_token = var.token_validity_units.refresh_token
  }

  # Prevent secrets from being updated
  lifecycle {
    ignore_changes = [
      client_secret,
    ]
  }
}

# Cognito User Pool Domain for ALB Authentication
resource "aws_cognito_user_pool_domain" "alb_domain" {
  count        = var.enable_alb_authentication && var.user_pool_domain != "" ? 1 : 0
  domain       = var.user_pool_domain
  user_pool_id = aws_cognito_user_pool.this.id
}

# Cognito Log Delivery Configuration to send logs to CloudWatch
# Note: Commented out due to provider compatibility issues - requires AWS provider 5.47+
# resource "aws_cognito_log_delivery_configuration" "this" {
#   user_pool_id = aws_cognito_user_pool.this.id

#   log_configurations {
#     event_source = "userAuthEvents"
#     log_level    = "INFO"
#     cloud_watch_logs_configuration {
#       log_group_arn = aws_cloudwatch_log_group.this.arn
#     }
#   }
# }