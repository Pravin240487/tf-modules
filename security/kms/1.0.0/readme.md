## Requirements

No specific requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `key_name` | Name for the KMS key and alias | `string` | n/a | ✅ Yes |
| `enable_key_rotation` | Enable automatic key rotation | `bool` | `true` | ❌ No |
| `deletion_window_in_days` | Waiting period for key deletion | `number` | `30` | ❌ No |
| `kms_key_policy` | IAM policy for the KMS key (as JSON string) | `string` | n/a | ✅ Yes |
| `tags` | Tags to apply to the key and alias | `map(string)` | `{ Terraformed = "true", Owner = "Octonomy.devops@talentship.io" }` | ❌ No |

## Outputs

| Name | Description |
|------|-------------|
| `target_key_id` | ARN of the KMS key |
