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
| [aws_sfn_state_machine.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_definition"></a> [definition](#input\_definition) | The Amazon States Language definition of the Step Function state machine | `string` | n/a | yes |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Whether to enable logging for the Step Function state machine | `bool` | `true` | no |
| <a name="input_enable_tracing"></a> [enable\_tracing](#input\_enable\_tracing) | Whether to enable X-Ray tracing for the Step Function state machine | `bool` | `false` | no |
| <a name="input_include_execution_data"></a> [include\_execution\_data](#input\_include\_execution\_data) | Whether to include execution data in the logs | `bool` | `true` | no |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | The destination for the logs (e.g., CloudWatch Log Group ARN) | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The logging level for the Step Function state machine (e.g., 'ALL', 'ERROR', 'FATAL') | `string` | `"ALL"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Step Function state machine | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The ARN of the IAM role that Step Function will assume | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the Step Function state machine | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the Step Function state machine |
| <a name="output_name"></a> [name](#output\_name) | The name of the Step Function state machine |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the IAM role that Step Function will assume |
