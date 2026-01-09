module "kms_key" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//encryption/kms/1.0.0"

  key_name                = "app-encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10

  kms_key_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowRootAccountAccess",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::123456789012:root"
        },
        Action   = "kms:*",
        Resource = "*"
      },
      {
        Sid    = "AllowSpecificIAMRoleAccess",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::123456789012:role/specific-role"
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = "*"
      }
    ]
  })
}