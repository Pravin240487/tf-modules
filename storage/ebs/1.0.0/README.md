```markdown
# EBS Module

This module creates an EBS volume.

## Usage

```terraform
module "ebs" {
  source = "./modules/ebs"

  availability_zone = "us-west-2a"
  size              = 100
  type              = "gp2"
  tags = {
    Name = "ebs-volume"
  }
}
```

## Inputs

| Name              | Description                               | Type   | Default | Required |
|-------------------|-------------------------------------------|--------|---------|----------|
| availability_zone | The availability zone to create the EBS volume in. | string |         | yes      |
| size              | The size of the EBS volume in GB.         | number |         | yes      |
| type              | The type of EBS volume.                   | string | `"gp2"` | no       |
| tags              | Tags to apply to the EBS volume.          | map    | `{}`    | no       |

## Outputs

| Name     | Description                |
|----------|----------------------------|
| id       | The ID of the EBS volume.  |
| arn      | The ARN of the EBS volume. |
| volume_id| The Volume ID.             |
```