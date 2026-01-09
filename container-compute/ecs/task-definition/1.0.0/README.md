## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_cloudwatch_log_group"></a> [ecs\_cloudwatch\_log\_group](#module\_ecs\_cloudwatch\_log\_group) | ../../../../monitoring/cloudwatch/1.0.0 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_awslogs_region"></a> [awslogs\_region](#input\_awslogs\_region) | The AWS region for CloudWatch logs. | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container within the ECS task definition. | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | The port on which the container listens. | `number` | `80` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of CPU units to allocate to the container. | `number` | `256` | no |
| <a name="input_host_port"></a> [host\_port](#input\_host\_port) | The port on the host to map to the container port. | `number` | `80` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN of the IAM role to use for the ECS task. | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The Docker image to use for the container. | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS key ID for encrypting CloudWatch logs. | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory (in MiB) to allocate to the container. | `number` | `512` | no |
| <a name="input_secret_arn"></a> [secret\_arn](#input\_secret\_arn) | The ARN of the AWS Secrets Manager secret containing sensitive data. | `string` | `""` | no |
| <a name="input_secret_keys"></a> [secret\_keys](#input\_secret\_keys) | A list of secret keys to retrieve from the Secrets Manager. | `list(string)` | `[]` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | Whether to skip the destroy operation for the ECS task definition. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the ECS task definition. | `map(string)` | n/a | yes |
| <a name="input_task_definition_name"></a> [task\_definition\_name](#input\_task\_definition\_name) | The name of the ECS task definition. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the ECS task definition. |
| <a name="output_arn_without_revision"></a> [arn\_without\_revision](#output\_arn\_without\_revision) | The ARN of the ECS task definition without the revision number. |
| <a name="output_revision"></a> [revision](#output\_revision) | The revision number of the ECS task definition. |
