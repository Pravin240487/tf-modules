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
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description for the Redis subnet group. If not provided, defaults to 'Redis subnet group for {name}' | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Redis subnet group | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs for the Redis subnet group. Must have at least 2 subnets for high availability | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the Redis subnet group | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Redis subnet group |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis subnet group |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | A list of subnet IDs for the Redis subnet group |
