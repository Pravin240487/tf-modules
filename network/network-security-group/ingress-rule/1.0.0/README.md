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
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_ipv4"></a> [cidr\_ipv4](#input\_cidr\_ipv4) | value of the CIDR IPv4 range to allow ingress traffic from | `string` | n/a | yes |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | value of the starting port for the ingress rule | `number` | n/a | yes |
| <a name="input_ip_protocol"></a> [ip\_protocol](#input\_ip\_protocol) | value of the IP protocol for the ingress rule (e.g., tcp, udp, icmp) | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | value of the security group ID to which this rule will be applied | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | value of the tags to apply to the ingress rule | `map(string)` | n/a | yes |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | value of the ending port for the ingress rule | `number` | n/a | yes |

## Outputs

No outputs.
