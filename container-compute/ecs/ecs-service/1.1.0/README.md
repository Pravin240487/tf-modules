## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_security_group"></a> [aws\_security\_group](#module\_aws\_security\_group) | s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/security-group/1.0.0 | n/a |
| <a name="module_aws_vpc_security_group_egress_rule"></a> [aws\_vpc\_security\_group\_egress\_rule](#module\_aws\_vpc\_security\_group\_egress\_rule) | s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/egress-rule/1.0.0 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.cpu_utilization_tracking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.memory_utilization_tracking](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling"></a> [autoscaling](#input\_autoscaling) | Enable or disable autoscaling for the ECS service. | `bool` | `false` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the ECS cluster. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the ECS cluster. | `string` | `"value"` | no |
| <a name="input_cpu_scale_in_cooldown"></a> [cpu\_scale\_in\_cooldown](#input\_cpu\_scale\_in\_cooldown) | Cooldown period after scaling in (in seconds). | `number` | `300` | no |
| <a name="input_cpu_scale_out_cooldown"></a> [cpu\_scale\_out\_cooldown](#input\_cpu\_scale\_out\_cooldown) | Cooldown period after scaling out (in seconds). | `number` | `120` | no |
| <a name="input_cpu_target_value"></a> [cpu\_target\_value](#input\_cpu\_target\_value) | Target value for CPU utilization. | `number` | `50` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The desired number of tasks in the ECS service. | `number` | `1` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | List of load balancers to attach to the ECS service. | <pre>list(object({<br/>    target_group_arn = string<br/>    container_name   = string<br/>    container_port   = number<br/>  }))</pre> | `[]` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Maximum number of tasks in the ECS service. | `number` | `2` | no |
| <a name="input_memory_scale_in_cooldown"></a> [memory\_scale\_in\_cooldown](#input\_memory\_scale\_in\_cooldown) | Cooldown period after scaling in (in seconds). | `number` | `300` | no |
| <a name="input_memory_scale_out_cooldown"></a> [memory\_scale\_out\_cooldown](#input\_memory\_scale\_out\_cooldown) | Cooldown period after scaling out (in seconds). | `number` | `120` | no |
| <a name="input_memory_target_value"></a> [memory\_target\_value](#input\_memory\_target\_value) | Target value for memory utilization. | `number` | `50` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | Minimum number of tasks in the ECS service. | `number` | `1` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the ECS service. | `string` | n/a | yes |
| <a name="input_service_security_group_name"></a> [service\_security\_group\_name](#input\_service\_security\_group\_name) | The name of the security group for the ECS service. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet IDs for the ECS service. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the ECS service. | `map(string)` | n/a | yes |
| <a name="input_task_definition_id"></a> [task\_definition\_id](#input\_task\_definition\_id) | The ID of the ECS task definition. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the ECS service will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | value of the ECS service ARN |
| <a name="output_ecs_security_group_id"></a> [ecs\_security\_group\_id](#output\_ecs\_security\_group\_id) | n/a |
