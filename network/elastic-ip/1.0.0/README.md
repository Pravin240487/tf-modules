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
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | The domain to associate the Elastic IP with. Valid values are 'vpc' or 'standard'. | `string` | `"vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allocation_id"></a> [allocation\_id](#output\_allocation\_id) | The allocation ID of the Elastic IP address. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private IP address of the Elastic IP. |
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | The public DNS name of the Elastic IP. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | The public IP address of the Elastic IP. |
