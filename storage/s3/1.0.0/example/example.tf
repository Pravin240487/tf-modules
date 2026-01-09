module "s3" {
  source = "storage/s3/1.0.0"

  bucket_name   = var.bucket_name
  kms_key_arn   = var.kms_key_arn
  bucket_policy = var.bucket_policy
  tags          = var.tags
}