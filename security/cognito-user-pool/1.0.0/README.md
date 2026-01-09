# Cognito User Pool Module with ALB Integration

This Terraform module creates an AWS Cognito User Pool with optional Application Load Balancer (ALB) authentication support.

## Features

- AWS Cognito User Pool with customizable attributes
- Lambda trigger integration for post-confirmation events
- Optional ALB authentication client and domain configuration
- Password policy enforcement
- Account recovery mechanisms
- CloudWatch logging integration

## ALB Authentication Setup

To enable ALB authentication, set the following variables:

```hcl
module "cognito_user_pool" {
  source = "./path/to/cognito-user-pool/1.0.0"
  
  # Basic configuration
  cognito_user_pool_name = "my-app-user-pool"
  post_confirmation_lambda_arn = aws_lambda_function.post_confirmation.arn
  tags = {
    Environment = "dev"
    Project     = "my-app"
  }
  
  # Enable ALB authentication
  enable_alb_authentication = true
  user_pool_domain          = "my-app-auth"
  callback_urls             = ["https://my-app.example.com/auth/callback"]
  logout_urls               = ["https://my-app.example.com/auth/logout"]
  
  # Optional: customize token validity
  access_token_validity     = 24  # hours
  id_token_validity        = 24  # hours
  refresh_token_validity   = 30  # days
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

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.89.0

## Provider Compatibility

This module is compatible with AWS Provider 5.89.0 and does not use the `aws_cognito_log_delivery_configuration` resource that requires newer provider versions.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cognito_user_pool.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_security_mode"></a> [advanced\_security\_mode](#input\_advanced\_security\_mode) | Advanced security mode for the Cognito User Pool (OFF, AUDIT, ENFORCED) | `string` | `"OFF"` | no |
| <a name="input_attribute_data_type"></a> [attribute\_data\_type](#input\_attribute\_data\_type) | Data type of the primary user pool attribute | `string` | `"String"` | no |
| <a name="input_cognito_user_pool_name"></a> [cognito\_user\_pool\_name](#input\_cognito\_user\_pool\_name) | The name of the Cognito User Pool | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Deletion protection for the Cognito User Pool (ACTIVE or INACTIVE) | `string` | `"ACTIVE"` | no |
| <a name="input_mutable"></a> [mutable](#input\_mutable) | Whether the primary user pool attribute can be changed after user creation | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the primary user pool attribute (typically 'email') | `string` | `"email"` | no |
| <a name="input_post_confirmation_lambda_arn"></a> [post\_confirmation\_lambda\_arn](#input\_post\_confirmation\_lambda\_arn) | ARN of the Lambda function to invoke after user confirmation | `string` | n/a | yes |
| <a name="input_required"></a> [required](#input\_required) | Whether the primary user pool attribute is required for user registration | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the Cognito User Pool | `map(string)` | n/a | yes |
| <a name="input_user_pool_schemas"></a> [user\_pool\_schemas](#input\_user\_pool\_schemas) | List of additional custom user pool attributes (schema) | <pre>list(object({<br/>    attribute_data_type = string<br/>    name                = string<br/>    required            = bool<br/>    mutable             = bool<br/>    string_attribute_constraints = optional(object({<br/>      min_length = number<br/>      max_length = number<br/>    }))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Cognito User Pool |
| <a name="output_deletion_protection"></a> [deletion\_protection](#output\_deletion\_protection) | Deletion protection status of the Cognito User Pool |
| <a name="output_id"></a> [id](#output\_id) | ID of the Cognito User Pool |
| <a name="output_lambda_config"></a> [lambda\_config](#output\_lambda\_config) | Lambda configuration for the Cognito User Pool |
| <a name="output_name"></a> [name](#output\_name) | Name of the Cognito User Pool |
| <a name="output_user_pool_add_ons"></a> [user\_pool\_add\_ons](#output\_user\_pool\_add\_ons) | User Pool Add-Ons configuration |