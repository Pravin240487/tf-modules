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
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_ipv4"></a> [cidr\_ipv4](#input\_cidr\_ipv4) | value of the CIDR IPv4 for the egress rule | `string` | n/a | yes |
| <a name="input_ip_protocol"></a> [ip\_protocol](#input\_ip\_protocol) | value of the IP protocol for the egress rule | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The ID of the security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value of the tags for the egress rule | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | value of the ARN of the egress rule |
| <a name="output_security_group_rule_id"></a> [security\_group\_rule\_id](#output\_security\_group\_rule\_id) | value of the security group rule ID |
