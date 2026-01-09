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
| [aws_wafv2_web_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | The ARN of the AWS resource to associate with the WAFv2 Web ACL (ALB, API Gateway, CloudFront, etc.) | `string` | n/a | yes |
| <a name="input_web_acl_arn"></a> [web\_acl\_arn](#input\_web\_acl\_arn) | The ARN of the WAFv2 Web ACL to associate with the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_association_id"></a> [association\_id](#output\_association\_id) | The ID of the WAFv2 Web ACL association |
| <a name="output_resource_arn"></a> [resource\_arn](#output\_resource\_arn) | The ARN of the resource associated with the WAFv2 Web ACL |
| <a name="output_web_acl_arn"></a> [web\_acl\_arn](#output\_web\_acl\_arn) | The ARN of the associated WAFv2 Web ACL |
