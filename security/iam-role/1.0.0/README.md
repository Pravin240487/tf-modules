## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | The JSON policy that grants an entity permission to assume the role | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the IAM role | `string` | `"test_role"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | values of the IAM role tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | value of the IAM role ARN |
| <a name="output_id"></a> [id](#output\_id) | value of the IAM role ID |
| <a name="output_name"></a> [name](#output\_name) | value of the IAM role name |
