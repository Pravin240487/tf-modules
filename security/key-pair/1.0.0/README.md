```markdown
# Key Pair Module

This module creates an EC2 Key Pair.

## Usage

```terraform
module "key_pair" {
    source = "../../security/key-pair/1.0.0"

    key_name = "my-key-pair"
}
```

## Inputs

| Name     | Description  | Type   | Default | Required |
|----------|--------------|--------|---------|----------|
| key_name | Name of the key pair | string |   ""      |    yes      |

## Outputs

| Name     | Description                  |
|----------|------------------------------|
| key_name | The name of the key pair     |
| public_key | The public key of the key pair |
| key_pair_id | The id of the key pair |
```