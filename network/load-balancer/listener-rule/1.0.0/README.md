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
| [aws_lb_listener_rule.https_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_header"></a> [host\_header](#input\_host\_header) | The host header to match for the rule | `list(string)` | `[]` | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | The ARN of the listener | `string` | n/a | yes |
| <a name="input_path_pattern"></a> [path\_pattern](#input\_path\_pattern) | The path pattern to match for the rule | `list(string)` | `[]` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | The priority of the rule | `number` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the target group to forward traffic to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the listener rule. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the listener rule. |
