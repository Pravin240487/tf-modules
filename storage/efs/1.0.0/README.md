# EFS Terraform Module

This module provisions an AWS Elastic File System (EFS) using Terraform.

## Usage

```hcl
module "efs" {
    source  = "git::https://github.com/your-org/tf-modules.git//storage/efs?ref=1.0.0"

    name                = "my-efs"
    vpc_id              = "vpc-xxxxxxx"
    subnet_ids          = ["subnet-xxxxxx", "subnet-yyyyyy"]
    performance_mode    = "generalPurpose"
    throughput_mode     = "bursting"
    encrypted           = true
    tags                = { Environment = "dev" }
}
```

## Inputs

| Name              | Description                          | Type     | Default     | Required |
|-------------------|--------------------------------------|----------|-------------|----------|
| name              | Name of the EFS file system          | string   | n/a         | yes      |
| vpc_id            | VPC ID for mount targets             | string   | n/a         | yes      |
| subnet_ids        | List of subnet IDs for mount targets | list     | n/a         | yes      |
| performance_mode  | EFS performance mode                 | string   | "generalPurpose" | no   |
| throughput_mode   | Throughput mode                      | string   | "bursting"  | no       |
| encrypted         | Whether to enable encryption         | bool     | true        | no       |
| tags              | Tags to apply                        | map      | {}          | no       |

## Outputs

| Name              | Description                          |
|-------------------|--------------------------------------|
| id                | EFS file system ID                   |
| arn               | EFS file system ARN                  |
| dns_name          | DNS name of the EFS                  |

## License

MIT