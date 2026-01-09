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
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_stickiness"></a> [enable\_stickiness](#input\_enable\_stickiness) | Whether to enable stickiness for the target group | `bool` | `false` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `3` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | The approximate amount of time between health checks of an individual target | `number` | `40` | no |
| <a name="input_matcher"></a> [matcher](#input\_matcher) | The HTTP codes to use when checking for a successful response from a target | `string` | `"200-499"` | no |
| <a name="input_path"></a> [path](#input\_path) | The destination for health checks on the targets | `string` | `"/"` | no |
| <a name="input_stickiness_cookie_duration"></a> [stickiness\_cookie\_duration](#input\_stickiness\_cookie\_duration) | The duration of the stickiness cookie in seconds | `number` | `3600` | no |
| <a name="input_stickiness_type"></a> [stickiness\_type](#input\_stickiness\_type) | The type of stickiness to use for the target group | `string` | `"lb_cookie"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the target group | `map(string)` | n/a | yes |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | The name of the target group | `string` | n/a | yes |
| <a name="input_target_group_port"></a> [target\_group\_port](#input\_target\_group\_port) | The port on which the target group is listening | `number` | `80` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time to wait when receiving a response from a target | `number` | `30` | no |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | The number of consecutive health check failures required before considering a target unhealthy | `number` | `3` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the target group is located | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the target group |
| <a name="output_id"></a> [id](#output\_id) | The ID of the target group |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The ARN of the load balancer associated with the target group |
| <a name="output_name"></a> [name](#output\_name) | The name of the target group |
