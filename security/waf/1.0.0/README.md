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
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_wafv2_ip_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_web_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_logging_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_response_bodies"></a> [custom\_response\_bodies](#input\_custom\_response\_bodies) | Map of custom response body configurations for blocked requests | <pre>map(object({<br/>    content_type = string<br/>    content      = string<br/>  }))</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the WAF Web ACL | `string` | `"WAF Web ACL"` | no |
| <a name="input_ip_address_version"></a> [ip\_address\_version](#input\_ip\_address\_version) | Specify IPV4 or IPV6 | `string` | `"IPV4"` | no |
| <a name="input_ipset_description"></a> [ipset\_description](#input\_ipset\_description) | Description of the IP set | `string` | `"IP set for whitelisted addresses"` | no |
| <a name="input_ipset_name"></a> [ipset\_name](#input\_ipset\_name) | The name of the IP set | `string` | `"whitelist-ip-set"` | no |
| <a name="input_ipset_scope"></a> [ipset\_scope](#input\_ipset\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application | `string` | `"CLOUDFRONT"` | no |
| <a name="input_log_group_kms_key_id"></a> [log\_group\_kms\_key\_id](#input\_log\_group\_kms\_key\_id) | The ARN of the KMS key to use for encrypting the CloudWatch log group. If not provided, the log group will use AWS managed encryption. | `string` | `null` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | The name of the CloudWatch log group for WAF logs | `string` | n/a | yes |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | The number of days to retain log events in the CloudWatch log group | `number` | `90` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the WAF Web ACL | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application | `string` | `"CLOUDFRONT"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_waf_metric_name"></a> [waf\_metric\_name](#input\_waf\_metric\_name) | The name of the CloudWatch metric for the WAF Web ACL | `string` | n/a | yes |
| <a name="input_waf_rules"></a> [waf\_rules](#input\_waf\_rules) | List of WAF rules to apply. Each rule supports multiple statement types and actions.<br/><br/>Supported statement types:<br/>- managed\_rule\_group: AWS/F5/Other managed rule groups<br/>- rate\_based: Rate limiting rules<br/>- geo\_match: Country/region based allow/block<br/>- ip\_set\_reference: IP whitelist/blacklist<br/>- byte\_match: String/pattern matching<br/>- size\_constraint: Request size limits<br/>- custom: Complex nested AND/OR/NOT statements<br/><br/>For CKV\_AWS\_192 Log4j protection compliance, include:<br/>- AWSManagedRulesKnownBadInputsRuleSet with action\_type = "override" and override\_action = "none"<br/>- AWSManagedRulesCommonRuleSet with action\_type = "override" and override\_action = "none"<br/>- Ensure no excluded\_rules that would disable Log4j protection | <pre>list(object({<br/>    name           = string<br/>    priority       = number<br/>    enabled        = bool<br/>    statement_type = string<br/>    action_type    = string<br/>    metric_name    = string<br/><br/>    # Override action for managed rules<br/>    override_action = optional(string)<br/><br/>    # Custom response configuration<br/>    custom_response   = optional(bool, false)<br/>    response_code     = optional(number)<br/>    response_body_key = optional(string)<br/><br/>    # Managed rule group specific<br/>    vendor_name     = optional(string)<br/>    rule_group_name = optional(string)<br/>    excluded_rules  = optional(list(string), [])<br/><br/>    # Rate-based rule specific<br/>    rate_limit            = optional(number)<br/>    aggregate_key_type    = optional(string)<br/>    evaluation_window_sec = optional(number)<br/><br/>    # Geo match specific<br/>    country_codes = optional(list(string))<br/><br/>    # IP set reference specific<br/>    ip_set_arn = optional(string)<br/><br/>    # Byte match specific<br/>    search_string         = optional(string)<br/>    positional_constraint = optional(string)<br/>    field_to_match        = optional(string)<br/>    header_name           = optional(string)<br/>    text_transformations = optional(list(object({<br/>      priority = number<br/>      type     = string<br/>    })), [])<br/><br/>    # Size constraint specific<br/>    size                  = optional(number)<br/>    comparison_operator   = optional(string)<br/>    size_constraint_field = optional(string)<br/>    size_header_name      = optional(string)<br/><br/>    # Custom statement specific (for complex AND/OR/NOT logic)<br/>    statement_nested_type = optional(string)<br/>    custom_statements = optional(list(object({<br/>      statement_type        = string<br/>      search_string         = optional(string)<br/>      positional_constraint = optional(string)<br/>      field_to_match        = optional(string)<br/>      header_name           = optional(string)<br/>      text_transformations = optional(list(object({<br/>        priority = number<br/>        type     = string<br/>      })), [])<br/>      country_codes = optional(list(string))<br/>      ip_set_arn    = optional(string)<br/>      nested_statement = optional(object({<br/>        statement_type = string<br/>        country_codes  = optional(list(string))<br/>        ip_set_arn     = optional(string)<br/>      }))<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_whitelist_ips"></a> [whitelist\_ips](#input\_whitelist\_ips) | List of IP addresses or CIDR blocks to whitelist | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_set_arn"></a> [ip\_set\_arn](#output\_ip\_set\_arn) | The ARN of the IP set |
| <a name="output_ip_set_id"></a> [ip\_set\_id](#output\_ip\_set\_id) | The ID of the IP set |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | The ARN of the CloudWatch log group |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | The name of the CloudWatch log group |
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | The ARN of the WAF Web ACL |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | The ID of the WAF Web ACL |
| <a name="output_web_acl_name"></a> [web\_acl\_name](#output\_web\_acl\_name) | The name of the WAF Web ACL |
