provider "aws" {
  region = "us-east-1"
}

module "sns_topic" {
  source = "./path-to-your-module" # Update with actual module path

  name                  = "alerting-topic"
  protocol              = "email"
  endpoint              = ["devops@example.com", "security@example.com"]
  enable_sns_encryption = true
  use_custom_kms_key    = true
  sns_kms_key_arn       = "arn:aws:kms:us-east-1:123456789012:key/abcde123-4567-890a-bcde-1234567890ab"
  kms_master_key_id     = "alias/kms/sns"

  tags = {
    Environment = "production"
    Owner       = "infra-team"
  }
}
