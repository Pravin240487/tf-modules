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
| [aws_glue_job.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command_name"></a> [command\_name](#input\_command\_name) | Name of the command for the Glue job (e.g., glueetl, pyspark) | `string` | `"glueetl"` | no |
| <a name="input_connections"></a> [connections](#input\_connections) | List of connections to use for the Glue job | `list(string)` | `[]` | no |
| <a name="input_default_arguments"></a> [default\_arguments](#input\_default\_arguments) | Default arguments for the Glue job | `map(string)` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Glue job | `string` | `""` | no |
| <a name="input_execution_class"></a> [execution\_class](#input\_execution\_class) | Execution class for the Glue job (e.g., STANDARD, FLEX) | `string` | `"STANDARD"` | no |
| <a name="input_glue_version"></a> [glue\_version](#input\_glue\_version) | Glue version to use for the job | `string` | `"2.0"` | no |
| <a name="input_job_run_queuing_enabled"></a> [job\_run\_queuing\_enabled](#input\_job\_run\_queuing\_enabled) | Enable job run queuing for the Glue job | `bool` | `false` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window for the Glue job | `string` | `""` | no |
| <a name="input_max_capacity"></a> [max\_capacity](#input\_max\_capacity) | Maximum capacity for the Glue job (in DPU) | `number` | n/a | yes |
| <a name="input_max_concurrent_runs"></a> [max\_concurrent\_runs](#input\_max\_concurrent\_runs) | Maximum number of concurrent runs for the Glue job | `number` | `1` | no |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | Maximum number of retries for the Glue job | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Glue job | `string` | `"MyGlueJob"` | no |
| <a name="input_non_overridable_arguments"></a> [non\_overridable\_arguments](#input\_non\_overridable\_arguments) | Non-overridable arguments for the Glue job | `map(string)` | `{}` | no |
| <a name="input_python_version"></a> [python\_version](#input\_python\_version) | Python version to use for the Glue job | `string` | `"3"` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | ARN of the IAM role to use for the Glue job | `string` | `""` | no |
| <a name="input_script_location"></a> [script\_location](#input\_script\_location) | S3 location of the script for the Glue job | `string` | `""` | no |
| <a name="input_security_configuration"></a> [security\_configuration](#input\_security\_configuration) | Security configuration for the Glue job | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the Glue job | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Timeout for the Glue job in minutes | `number` | `10` | no |
| <a name="input_worker_type"></a> [worker\_type](#input\_worker\_type) | Worker type for the Glue job (e.g., G.1X, G.2X) | `string` | `"G.1X"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Glue job |
| <a name="output_id"></a> [id](#output\_id) | ID of the Glue job |
