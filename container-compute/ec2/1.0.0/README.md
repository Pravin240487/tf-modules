
# EC2 Instance Module

This module creates an EC2 instance.

## Usage

```terraform
module "ec2_instance" {
  source  = "path/to/this/module"

  ami                    = "ami-xxxxxxxxxxxxxxxxx"
  instance_type          = "t2.micro"
  key_name               = "my-keypair"
  subnet_id              = "subnet-xxxxxxxxxxxxxxxxx"
  security_group_ids = ["sg-xxxxxxxxxxxxxxxxx"]

  tags = {
    Name = "MyEC2Instance"
  }
}
```

## Inputs

| Name                  | Description                               | Type   | Default | Required |
|-----------------------|-------------------------------------------|--------|---------|----------|
| ami                   | The AMI to use for the instance.          | string |         | yes      |
| instance_type         | The type of instance to create.           | string | `t2.micro`| no       |
| key_name              | The name of the SSH key to attach.        | string |         | yes      |
| subnet_id             | The subnet ID to launch the instance in. | string |         | yes      |
| security_group_ids | A list of security group IDs to apply. | list(string) | [] | yes |
| tags                  | A map of tags to apply to the instance. | map(string) | `{}`    | no       |

## Outputs

| Name       | Description                                  |
|------------|----------------------------------------------|
| public_ip | The public IP address of the instance.       |
| private_ip | The private IP address of the instance.      |
| id         | The ID of the EC2 instance.                  |

## Providers

| Name | Version |
|------|---------|
| aws  |  >= 4.0 |

## Modules
None

## Resources

*   [aws\_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)



```