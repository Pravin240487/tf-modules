## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_aws.useast1"></a> [aws.useast1](#provider\_aws.useast1) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_logging"></a> [logging](#module\_logging) | s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/s3/1.0.0 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_cloudwatch_log_delivery.cloudfront_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery) | resource |
| [aws_cloudwatch_log_delivery_destination.cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery_destination) | resource |
| [aws_cloudwatch_log_delivery_source.cloudfront_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_delivery_source) | resource |
| [aws_cloudwatch_log_group.cloudfront_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudfront_cache_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_cloudfront_cache_policy.this_](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_cache_policy) | data source |
| [aws_cloudfront_origin_request_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_origin_request_policy) | data source |
| [aws_cloudfront_origin_request_policy.this_](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_origin_request_policy) | data source |
| [aws_cloudfront_response_headers_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_response_headers_policy) | data source |
| [aws_cloudfront_response_headers_policy.this_](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudfront_response_headers_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | The ARN of the ACM certificate to associate with the CloudFront distribution. | `string` | `null` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | A list of alternate domain names (CNAMEs) for this CloudFront distribution. | `list(string)` | `[]` | no |
| <a name="input_cf_enabled"></a> [cf\_enabled](#input\_cf\_enabled) | Whether the distribution is enabled to accept end user requests for content | `bool` | `true` | no |
| <a name="input_cf_logging_include_cookies"></a> [cf\_logging\_include\_cookies](#input\_cf\_logging\_include\_cookies) | Whether to include cookies in the CloudFront access logs. | `bool` | `false` | no |
| <a name="input_cf_logging_prefix"></a> [cf\_logging\_prefix](#input\_cf\_logging\_prefix) | The prefix for the CloudFront logs stored in the S3 bucket. | `string` | `"cloudfront/"` | no |
| <a name="input_cloudfront_default_certificate"></a> [cloudfront\_default\_certificate](#input\_cloudfront\_default\_certificate) | Specifies whether CloudFront should use the default certificate or the ACM certificate. | `bool` | `true` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | A comment about the CloudFront distribution, useful for identification. | `string` | `"Terraformed"` | no |
| <a name="input_default_allowed_methods"></a> [default\_allowed\_methods](#input\_default\_allowed\_methods) | The list of allowed HTTP methods for the default cache behavior. | `list(string)` | <pre>[<br/>  "DELETE",<br/>  "GET",<br/>  "HEAD",<br/>  "OPTIONS",<br/>  "PATCH",<br/>  "POST",<br/>  "PUT"<br/>]</pre> | no |
| <a name="input_default_cache_policy_id"></a> [default\_cache\_policy\_id](#input\_default\_cache\_policy\_id) | The ID of the cache policy to use for the default cache behavior. | `string` | `""` | no |
| <a name="input_default_cached_methods"></a> [default\_cached\_methods](#input\_default\_cached\_methods) | The list of HTTP methods that CloudFront caches for the default cache behavior. | `list(string)` | <pre>[<br/>  "GET",<br/>  "HEAD",<br/>  "OPTIONS"<br/>]</pre> | no |
| <a name="input_default_default_ttl"></a> [default\_default\_ttl](#input\_default\_default\_ttl) | The default TTL (Time to Live) in seconds for the default cache behavior. | `number` | `0` | no |
| <a name="input_default_max_ttl"></a> [default\_max\_ttl](#input\_default\_max\_ttl) | The maximum TTL (Time to Live) in seconds for the default cache behavior. | `number` | `0` | no |
| <a name="input_default_min_ttl"></a> [default\_min\_ttl](#input\_default\_min\_ttl) | The minimum TTL (Time to Live) in seconds for the default cache behavior. | `number` | `0` | no |
| <a name="input_default_origin_request_policy_id"></a> [default\_origin\_request\_policy\_id](#input\_default\_origin\_request\_policy\_id) | The ID of the origin request policy to use for the default cache behavior. | `string` | `""` | no |
| <a name="input_default_response_headers_policy_id"></a> [default\_response\_headers\_policy\_id](#input\_default\_response\_headers\_policy\_id) | The ID of the response headers policy to use for the default cache behavior. | `string` | `""` | no |
| <a name="input_default_root_object"></a> [default\_root\_object](#input\_default\_root\_object) | The default root object that CloudFront returns when a viewer requests the root URL of the distribution. | `string` | `""` | no |
| <a name="input_default_viewer_protocol_policy"></a> [default\_viewer\_protocol\_policy](#input\_default\_viewer\_protocol\_policy) | The viewer protocol policy for the default cache behavior. | `string` | `"redirect-to-https"` | no |
| <a name="input_enableOriginAccessControl"></a> [enableOriginAccessControl](#input\_enableOriginAccessControl) | Specifies whether to enable origin access control for the CloudFront distribution. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the CloudFront distribution (e.g., 'dev', 'prod'). | `string` | n/a | yes |
| <a name="input_ipv6"></a> [ipv6](#input\_ipv6) | Specifies whether IPv6 is enabled for the CloudFront distribution. | `bool` | `false` | no |
| <a name="input_kms_key_ids"></a> [kms\_key\_ids](#input\_kms\_key\_ids) | The KMS key ID for encrypting the CloudFront distribution's data at rest. | `string` | `""` | no |
| <a name="input_log_output_format"></a> [log\_output\_format](#input\_log\_output\_format) | The format for the CloudFront access logs (either 'json' or 'common-log-format'). | `string` | `"json"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | The number of days to retain access logs for the CloudFront distribution. | `number` | `90` | no |
| <a name="input_log_type"></a> [log\_type](#input\_log\_type) | The type of logs to be generated for the CloudFront distribution (e.g., 'ACCESS\_LOGS'). | `string` | `"ACCESS_LOGS"` | no |
| <a name="input_minimum_protocol_version"></a> [minimum\_protocol\_version](#input\_minimum\_protocol\_version) | The minimum SSL/TLS protocol version that CloudFront uses to communicate with viewers. | `string` | `"TLSv1.2_2021"` | no |
| <a name="input_oac_description"></a> [oac\_description](#input\_oac\_description) | A description for the origin access control configuration. | `string` | `"Terraformed"` | no |
| <a name="input_oac_origin_type"></a> [oac\_origin\_type](#input\_oac\_origin\_type) | The type of the origin for the CloudFront distribution (e.g., 's3' or 'custom'). | `string` | `"s3"` | no |
| <a name="input_oac_signing_behavior"></a> [oac\_signing\_behavior](#input\_oac\_signing\_behavior) | The signing behavior for the origin access control ('always' or 'never'). | `string` | `"always"` | no |
| <a name="input_oac_signing_protocol"></a> [oac\_signing\_protocol](#input\_oac\_signing\_protocol) | The signing protocol for the origin access control ('sigv4' for AWS Signature Version 4). | `string` | `"sigv4"` | no |
| <a name="input_ordered_cache_behavior"></a> [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | A list of ordered cache behaviors that specify how CloudFront handles requests for specific paths. | <pre>list(object({<br/>    path_pattern               = optional(string, "/*.png")<br/>    allowed_methods            = optional(list(string), ["GET", "HEAD"])<br/>    cached_methods             = optional(list(string), ["GET", "HEAD"])<br/>    cache_policy_id            = optional(string, "CachingOptimized")<br/>    origin_request_policy_id   = optional(string, "Managed-AllViewer")<br/>    response_headers_policy_id = optional(string, "Managed-CORS-With-Preflight")<br/>    min_ttl                    = optional(number, 0)<br/>    default_ttl                = optional(number, 0)<br/>    max_ttl                    = optional(number, 0)<br/>    compress                   = optional(bool, false)<br/>    viewer_protocol_policy     = optional(string, "redirect-to-https")<br/>  }))</pre> | `[]` | no |
| <a name="input_origin"></a> [origin](#input\_origin) | The origin domain name for the CloudFront distribution (e.g., your S3 bucket or load balancer). | `string` | n/a | yes |
| <a name="input_origin_keepalive_timeout"></a> [origin\_keepalive\_timeout](#input\_origin\_keepalive\_timeout) | The keep-alive timeout in seconds for connections to the origin. | `number` | `5` | no |
| <a name="input_origin_protocol_policy"></a> [origin\_protocol\_policy](#input\_origin\_protocol\_policy) | The protocol policy for the origin, either 'http-only', 'https-only', or 'match-viewer'. | `string` | `"https-only"` | no |
| <a name="input_origin_read_timeout"></a> [origin\_read\_timeout](#input\_origin\_read\_timeout) | The read timeout in seconds for responses from the origin. | `number` | `30` | no |
| <a name="input_origin_ssl_protocols"></a> [origin\_ssl\_protocols](#input\_origin\_ssl\_protocols) | The SSL protocols that CloudFront uses to connect to the origin. | `list(string)` | <pre>[<br/>  "TLSv1.2"<br/>]</pre> | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for the CloudFront distribution. Options are 'PriceClass\_100', 'PriceClass\_200', 'PriceClass\_All'. | `string` | `"PriceClass_All"` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The ARN of the IAM role to be used by the CloudFront distribution for accessing AWS resources. | `string` | n/a | yes |
| <a name="input_ssl_support_method"></a> [ssl\_support\_method](#input\_ssl\_support\_method) | The SSL support method for the CloudFront distribution, either 'sni-only' or 'vip'. | `string` | `"sni-only"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the resource. | `map(string)` | n/a | yes |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | The ID of the Web ACL (Access Control List) to associate with the CloudFront distribution. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | The ARN of the CloudFront distribution |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | The ID of the CloudFront distribution |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | The domain name assigned by CloudFront (e.g., dxxxxx.cloudfront.net) |
| <a name="output_etag"></a> [etag](#output\_etag) | The ETag of the distribution’s configuration |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The hosted zone ID for use with Route 53 alias records |
| <a name="output_in_progress_validation_batches"></a> [in\_progress\_validation\_batches](#output\_in\_progress\_validation\_batches) | Number of invalidation batches in progress |
| <a name="output_last_modified_time"></a> [last\_modified\_time](#output\_last\_modified\_time) | Timestamp of the last modification |
| <a name="output_status"></a> [status](#output\_status) | The current status of the distribution (e.g., Deployed) |
