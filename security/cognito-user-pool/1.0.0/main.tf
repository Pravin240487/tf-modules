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

  # Lambda trigger configuration for custom authentication flows
  # Post-confirmation trigger executes after successful user verification
  lambda_config {
    post_confirmation = var.post_confirmation_lambda_arn
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

# Cognito Log Delivery Configuration to send logs to CloudWatch
resource "aws_cognito_log_delivery_configuration" "this" {
  user_pool_id = aws_cognito_user_pool.this.id

  log_configurations {
    event_source = "userAuthEvents"
    log_level    = "INFO"
    cloud_watch_logs_configuration {
      log_group_arn = aws_cloudwatch_log_group.this.arn
    }
  }
}