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
| [aws_elasticache_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_family"></a> [family](#input\_family) | The family of the Redis parameter group (e.g., redis7, redis6.x, redis5.0) | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Redis parameter group | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of Redis parameter name/value pairs for performance tuning | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the Redis parameter group | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Redis parameter group |
| <a name="output_family"></a> [family](#output\_family) | The family of the Redis parameter group |
| <a name="output_name"></a> [name](#output\_name) | The name of the Redis parameter group |
