# Example 1: Secret with KMS encryption and automatic rotation
module "secret_manager_with_kms_and_rotation" {
  source = "../"

  secret_name        = "example-secret-with-kms-rotation"
  secret_description = "Example secret with KMS encryption and automatic rotation"
  secret_keys = {
    username = "exampleuser"
    password = "examplepassword"
  }
  kms_key_id               = "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id"
  enable_rotation          = true
  rotation_lambda_arn      = "arn:aws:lambda:us-east-1:123456789012:function:your-rotation-lambda"
  automatically_after_days = 30
  tags = {
    Environment = "dev"
    Project     = "security"
    Encryption  = "customer-managed"
  }
}

# Example 2: Secret with AWS managed encryption (no KMS key specified)
module "secret_manager_aws_managed_encryption" {
  source = "../"

  secret_name        = "example-secret-aws-managed"
  secret_description = "Example secret with AWS managed encryption"
  secret_keys = {
    api_key = "example-api-key"
    token   = "example-token"
  }
  # kms_key_id not specified - will use AWS managed encryption
  tags = {
    Environment = "dev"
    Project     = "security"
    Encryption  = "aws-managed"
  }
}

# Example 3: Secret with custom KMS key but no rotation
module "secret_manager_custom_kms_no_rotation" {
  source = "../"

  secret_name        = "example-secret-custom-kms"
  secret_description = "Example secret with custom KMS encryption but no rotation"
  secret_keys = {
    database_url      = "postgresql://localhost:5432/mydb"
    database_password = "secretpassword"
  }
  kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/your-custom-kms-key-id"
  # enable_rotation defaults to false
  tags = {
    Environment = "production"
    Project     = "security"
    Encryption  = "customer-managed"
  }
}

# Example 4: Minimal secret configuration (AWS managed encryption, no rotation)
module "secret_manager_minimal" {
  source = "../"

  secret_name        = "example-minimal-secret"
  secret_description = "Minimal secret configuration"
  secret_keys = {
    simple_key = "simple_value"
  }
  # kms_key_id defaults to null (AWS managed)
  # enable_rotation defaults to false
  # tags defaults to empty map
}