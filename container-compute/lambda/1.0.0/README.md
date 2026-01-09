## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//v1/iam/1.0.0 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_event_source_mapping.trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.ecr_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.lambda_source](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_archive_file_type"></a> [archive\_file\_type](#input\_archive\_file\_type) | The type of the archive file | `string` | `"zip"` | no |
| <a name="input_batch_size"></a> [batch\_size](#input\_batch\_size) | batch size for the event source mapping | `number` | `10` | no |
| <a name="input_create_ecr_lambda"></a> [create\_ecr\_lambda](#input\_create\_ecr\_lambda) | Whether to create an ECR lambda function | `bool` | `false` | no |
| <a name="input_create_event_source_mapping"></a> [create\_event\_source\_mapping](#input\_create\_event\_source\_mapping) | Whether to create an event source mapping for the lambda function | `bool` | `false` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Whether to create an IAM role for the lambda function | `bool` | `true` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | The environment variables of the lambda function | `map(string)` | `{}` | no |
| <a name="input_event_source_arn"></a> [event\_source\_arn](#input\_event\_source\_arn) | The ARN of the event source for the lambda function | `string` | `""` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name of the lambda function | `string` | n/a | yes |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | The image URI of the lambda function | `string` | `""` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | The handler of the lambda function | `string` | `"index.handler"` | no |
| <a name="input_lambda_role_name"></a> [lambda\_role\_name](#input\_lambda\_role\_name) | The name of the IAM role for the lambda function | `string` | `""` | no |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | The runtime of the lambda function | `string` | `"nodejs18.x"` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The memory size of the lambda function | `number` | `128` | no |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | The output path of the lambda function | `string` | `"./lambda.zip"` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | The package type of the lambda function | `string` | `"Image"` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The ARN of the IAM role for the lambda function | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | The security group IDs for the lambda function | `list(string)` | `[]` | no |
| <a name="input_source_dir"></a> [source\_dir](#input\_source\_dir) | The source directory of the lambda function | `string` | `"./"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The subnet IDs for the lambda function | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to apply to the lambda function | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The timeout of the lambda function | `number` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_lambda_arn"></a> [ecr\_lambda\_arn](#output\_ecr\_lambda\_arn) | The ARN of the ECR Lambda function. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the IAM role created for the Lambda function. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | The name of the IAM role created for the Lambda function. |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | The ARN of the Lambda function. |
