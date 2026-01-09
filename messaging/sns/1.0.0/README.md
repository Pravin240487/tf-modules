# AWS SNS Topic Terraform Module

This Terraform module provisions an Amazon SNS topic with optional encryption and subscriptions.

## Features

- Creates an SNS topic with a customizable delivery policy.
- Supports optional KMS encryption (AWS-managed or customer-managed key).
- Creates multiple SNS subscriptions to the topic (e.g., email, HTTPS, etc.).

## Usage

```hcl
module "sns_topic" {
  source = "./path-to-this-module"

  name                  = "my-sns-topic"
  protocol              = "email"
  endpoint              = ["alerts@example.com", "ops@example.com"]
  enable_sns_encryption = true
  use_custom_kms_key    = true
  sns_kms_key_arn       = "arn:aws:kms:us-east-1:123456789012:key/abcde123-4567-890a-bcde-1234567890ab"
  kms_master_key_id     = "alias/kms/sns"
  tags = {
    Environment = "prod"
    Team        = "DevOps"
  }
}
