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
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The amount of storage (in GiB) to allocate for the RDS instance | `number` | `20` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Whether to apply changes immediately or during the next maintenance window | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Whether to enable auto minor version upgrades for the RDS instance | `bool` | `true` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Number of days to retain backups | `number` | n/a | yes |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | Preferred backup window (in UTC, format: hh24:mi-hh24:mi) | `string` | n/a | yes |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Whether to copy tags to snapshots of the RDS instance | `bool` | `false` | no |
| <a name="input_db_instance_name"></a> [db\_instance\_name](#input\_db\_instance\_name) | The name of the RDS instance | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create within the RDS instance | `string` | `"masterdb"` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of the DB subnet group to associate with the RDS instance | `string` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | Whether to enable deletion protection for the RDS instance | `bool` | `true` | no |
| <a name="input_enabled_logs"></a> [enabled\_logs](#input\_enabled\_logs) | A list of log types to enable for the RDS instance | `list(string)` | <pre>[<br/>  "postgresql",<br/>  "upgrade"<br/>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine to use for the RDS instance | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the database engine to use | `string` | `"16.3"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | [DEPRECATED] The environment for which the RDS instance is being created (e.g., dev, staging, prod) | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance class for the RDS instance | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS key ID for encrypting the RDS instance | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Preferred maintenance window (in UTC, format: ddd:hh24:mi-ddd:hh24:mi) | `string` | n/a | yes |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | The maximum amount of storage (in GiB) to allow for the RDS instance | `number` | `22` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | The interval (in seconds) for enhanced monitoring of the RDS instance | `number` | `60` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Whether to create a Multi-AZ RDS instance | `bool` | `true` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | A description for the RDS parameter group | `string` | `"RDS Parameter Group"` | no |
| <a name="input_parameter_group_family"></a> [parameter\_group\_family](#input\_parameter\_group\_family) | The family of the RDS parameter group (e.g., 'postgres15', 'mysql8.0') | `string` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | The name of the RDS parameter group to associate with the RDS instance | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A list of parameters to set for the RDS instance | <pre>list(object({<br/>    name         = string<br/>    value        = string<br/>    apply_method = optional(string, "pending-reboot") # Default to 'pending-reboot' if not specified<br/>  }))</pre> | `[]` | no |
| <a name="input_password"></a> [password](#input\_password) | The master password for the RDS instance | `string` | n/a | yes |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Whether to enable Performance Insights for the RDS instance | `bool` | `true` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The KMS key ID for encrypting Performance Insights data | `string` | `null` | no |
| <a name="input_project_version"></a> [project\_version](#input\_project\_version) | [DEPRECATED] The version of the project for which the RDS instance is being created | `string` | `null` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Whether the RDS instance should be publicly accessible | `bool` | `false` | no |
| <a name="input_rds_monitoring_role_arn"></a> [rds\_monitoring\_role\_arn](#input\_rds\_monitoring\_role\_arn) | The ARN of the IAM role for RDS monitoring | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | [DEPRECATED] The AWS region where the RDS instance will be deployed | `string` | `null` | no |
| <a name="input_region_suffix"></a> [region\_suffix](#input\_region\_suffix) | [DEPRECATED] The region suffix to append to resource names (e.g., us-east-1, eu-west-1) | `string` | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Whether to skip the final snapshot when deleting the RDS instance | `bool` | `true` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Whether to enable storage encryption for the RDS instance | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The storage type for the RDS instance | `string` | `"gp3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the RDS instance | `map(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The master username for the RDS instance | `string` | `"masteruser"` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | A list of VPC security group IDs to associate with the RDS instance | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the RDS instance |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | The name of the database created within the RDS instance |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint of the RDS instance |
| <a name="output_id"></a> [id](#output\_id) | ID of the RDS Parameter Group |
| <a name="output_name"></a> [name](#output\_name) | The name of the RDS instance |
| <a name="output_parameter_group_arn"></a> [parameter\_group\_arn](#output\_parameter\_group\_arn) | ARN of the RDS Parameter Group |
| <a name="output_parameter_group_family"></a> [parameter\_group\_family](#output\_parameter\_group\_family) | Family of the RDS Parameter Group |
| <a name="output_parameter_group_name"></a> [parameter\_group\_name](#output\_parameter\_group\_name) | Name of the RDS Parameter Group |
