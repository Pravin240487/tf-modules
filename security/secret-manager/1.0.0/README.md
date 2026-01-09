# AWS Secrets Manager Terraform Module

This module creates an AWS Secrets Manager secret with optional automatic rotation capabilities.

## Features

- Create AWS Secrets Manager secret with optional KMS encryption
- Store key-value pairs as JSON in the secret
- **Optional automatic rotation** with Lambda function
- **Optional KMS encryption** (defaults to AWS managed encryption)
- Flexible tagging support
- Input validation for rotation configuration

## Usage

### Basic Secret (AWS Managed Encryption, No Rotation)

```hcl
module "secret_manager" {
  source = "./modules/secret-manager"

  secret_name        = "my-application-secret"
  secret_description = "Application database credentials"
  secret_keys = {
    username = "dbuser"
    password = "dbpassword"
  }
  # kms_key_id not specified - uses AWS managed encryption
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### Secret with Custom KMS Encryption

```hcl
module "secret_manager_with_kms" {
  source = "./modules/secret-manager"

  secret_name        = "my-application-secret"
  secret_description = "Application credentials with custom KMS encryption"
  secret_keys = {
    username = "dbuser"
    password = "dbpassword"
  }
  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id"
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

### Secret with Automatic Rotation

```hcl
module "secret_manager_with_rotation" {
  source = "./modules/secret-manager"

  secret_name        = "my-application-secret"
  secret_description = "Application database credentials with rotation"
  secret_keys = {
    username = "dbuser"
    password = "dbpassword"
  }
  kms_key_id                = "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id"
  enable_rotation           = true
  rotation_lambda_arn       = "arn:aws:lambda:us-east-1:123456789012:function:rotation-lambda"
  automatically_after_days  = 30
  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_rotation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_secret_description"></a> [secret\_description](#input\_secret\_description) | Description of the secret | `string` | n/a | yes |
| <a name="input_secret_name"></a> [secret\_name](#input\_secret\_name) | Name of the secret | `string` | n/a | yes |
| <a name="input_secret_keys"></a> [secret\_keys](#input\_secret\_keys) | Map of key-value pairs to store in the secret | `map(string)` | `{}` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ARN to encrypt the secret. If not provided, AWS managed key will be used | `string` | `null` | no |
| <a name="input_enable_rotation"></a> [enable\_rotation](#input\_enable\_rotation) | Whether to enable automatic rotation for this secret | `bool` | `false` | no |
| <a name="input_rotation_lambda_arn"></a> [rotation\_lambda\_arn](#input\_rotation\_lambda\_arn) | ARN of the Lambda function that can rotate this secret. Required when enable_rotation is true | `string` | `null` | no |
| <a name="input_automatically_after_days"></a> [automatically\_after\_days](#input\_automatically\_after\_days) | Number of days between automatic rotations | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | ARN of the secret |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | ID of the secret |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | The name of the created Secrets Manager secret |

## Notes

- When `enable_rotation` is set to `true`, `rotation_lambda_arn` must be provided
- The module includes input validation to ensure proper rotation configuration
- Rotation is disabled by default for backward compatibility
- **KMS encryption is optional**: If `kms_key_id` is not provided, AWS managed encryption will be used
- **AWS managed encryption** provides good security for most use cases and is more cost-effective
- **Customer managed KMS keys** provide additional control and are required for compliance in some scenarios
- The secret content is stored as JSON with the provided key-value pairs
