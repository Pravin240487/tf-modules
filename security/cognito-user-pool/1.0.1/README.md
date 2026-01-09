# Cognito User Pool Module with ALB Integration

This Terraform module creates an AWS Cognito User Pool with optional Application Load Balancer (ALB) authentication support and Lambda trigger integration.

## Features

- AWS Cognito User Pool with customizable attributes
- Optional Lambda trigger integration for post-confirmation events
- Optional ALB authentication client and domain configuration
- Password policy enforcement
- Account recovery mechanisms
- CloudWatch logging integration
- Advanced security modes (OFF, AUDIT, ENFORCED)
- Deletion protection support

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.89.0

## Usage

### Basic Example (without Lambda)

```hcl
module "cognito_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"
  
  cognito_user_pool_name = "my-app-user-pool"
  advanced_security_mode = "AUDIT"
  deletion_protection    = "INACTIVE"
  
  # Primary email attribute
  attribute_data_type = "String"
  name                = "email"
  required            = true
  mutable             = false
  
  # No Lambda required
  post_confirmation_lambda_arn = ""
  
  tags = {
    Environment = "dev"
    Project     = "my-app"
  }
}
```

### With Lambda Post-Confirmation Trigger

```hcl
module "cognito_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"
  
  cognito_user_pool_name       = "my-app-user-pool"
  post_confirmation_lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:post-confirmation"
  
  tags = {
    Environment = "production"
  }
}
```

### With Custom Attributes

```hcl
module "cognito_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"
  
  cognito_user_pool_name = "my-app-user-pool"
  
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
  }
}
```

### With ALB Authentication

```hcl
module "cognito_user_pool" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/cognito-user-pool/1.0.1"
  
  cognito_user_pool_name = "my-app-user-pool"
  
  # Enable ALB authentication
  enable_alb_authentication = true
  user_pool_domain          = "my-app-auth"
  callback_urls             = ["https://my-app.example.com/oauth2/idpresponse"]
  logout_urls               = ["https://my-app.example.com/logout"]
  
  # Optional: customize token validity
  access_token_validity  = 24  # hours
  id_token_validity      = 24  # hours
  refresh_token_validity = 30  # days
  
  post_confirmation_lambda_arn = ""
  
  tags = {
    Environment = "production"
    ALB         = "enabled"
  }
}
```

## ALB Listener Rule Integration

Use the module outputs to configure ALB listener rules:

```hcl
resource "aws_lb_listener_rule" "auth" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type = "authenticate-cognito"
    authenticate_cognito {
      user_pool_arn       = module.cognito_user_pool.arn
      user_pool_client_id = module.cognito_user_pool.user_pool_client_id
      user_pool_domain    = module.cognito_user_pool.user_pool_domain
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    path_pattern {
      values = ["/protected/*"]
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cognito_user_pool_name | The name of the Cognito User Pool | `string` | n/a | yes |
| tags | A map of tags to assign to the Cognito User Pool | `map(string)` | n/a | yes |
| advanced_security_mode | Advanced security mode (OFF, AUDIT, ENFORCED) | `string` | `"OFF"` | no |
| deletion_protection | Deletion protection (ACTIVE or INACTIVE) | `string` | `"ACTIVE"` | no |
| attribute_data_type | Data type of the primary attribute | `string` | `"String"` | no |
| name | Name of the primary attribute (typically 'email') | `string` | `"email"` | no |
| required | Whether the primary attribute is required | `bool` | `true` | no |
| mutable | Whether the primary attribute can be changed | `bool` | `false` | no |
| user_pool_schemas | List of additional custom user pool attributes | `list(object)` | `[]` | no |
| post_confirmation_lambda_arn | ARN of Lambda function for post-confirmation (optional) | `string` | `""` | no |
| enable_alb_authentication | Enable Cognito User Pool Client for ALB | `bool` | `false` | no |
| callback_urls | List of allowed callback URLs for ALB | `list(string)` | `[]` | no |
| logout_urls | List of allowed logout URLs for ALB | `list(string)` | `[]` | no |
| user_pool_domain | Domain for Cognito User Pool | `string` | `""` | no |
| auto_verified_attributes | Attributes to be auto-verified | `list(string)` | `["email"]` | no |
| username_attributes | Attributes used for username | `list(string)` | `["email"]` | no |
| password_minimum_length | Minimum password length | `number` | `8` | no |
| password_require_lowercase | Require lowercase characters | `bool` | `true` | no |
| password_require_numbers | Require numbers | `bool` | `true` | no |
| password_require_symbols | Require symbols | `bool` | `true` | no |
| password_require_uppercase | Require uppercase characters | `bool` | `true` | no |
| recovery_mechanisms | List of recovery mechanisms | `list(object)` | See variables.tf | no |
| access_token_validity | Access token validity in hours | `number` | `24` | no |
| id_token_validity | ID token validity in hours | `number` | `24` | no |
| refresh_token_validity | Refresh token validity in days | `number` | `30` | no |
| token_validity_units | Token validity units configuration | `object` | See variables.tf | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Name of the Cognito User Pool |
| arn | ARN of the Cognito User Pool |
| id | ID of the Cognito User Pool |
| user_pool_add_ons | User Pool Add-Ons configuration |
| lambda_config | Lambda configuration (if configured) |
| deletion_protection | Deletion protection status |
| user_pool_client_id | Client ID for ALB authentication |
| user_pool_client_secret | Client secret for ALB authentication (sensitive) |
| user_pool_domain | Domain for ALB authentication |
| user_pool_domain_hosted_zone_id | Hosted Zone ID of the domain |
| user_pool_endpoint | Endpoint name of the User Pool |

## Key Changes from Version 1.0.0

- **Lambda is now optional**: `post_confirmation_lambda_arn` can be set to empty string (`""`)
- Added ALB authentication support
- Added CloudWatch log group creation
- Enhanced password policy configuration
- Added account recovery mechanisms
- Added token validity configuration
- More flexible attribute configuration

## Examples

See the [example](./example/example.tf) directory for complete usage examples including:
- Basic user pool without Lambda
- User pool with Lambda trigger
- User pool with custom attributes
- User pool with ALB authentication
- Complete configuration with all features

## Notes

- The `post_confirmation_lambda_arn` parameter is optional in version 1.0.1. Set it to `""` if you don't need Lambda integration.
- When using ALB authentication, ensure your callback URLs match your ALB DNS name.
- CloudWatch Log Group is automatically created with 90-day retention.
- The module creates managed CloudWatch logs but does not use `aws_cognito_log_delivery_configuration` for provider compatibility.
