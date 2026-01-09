locals {
  # Validation: ensure rotation_lambda_arn is provided when rotation is enabled
  validate_rotation_config = var.enable_rotation && var.rotation_lambda_arn == null ? tobool("rotation_lambda_arn must be provided when enable_rotation is true") : true
}

resource "aws_secretsmanager_secret" "this" {
  description = var.secret_description
  name        = var.secret_name
  kms_key_id  = var.kms_key_id != null ? var.kms_key_id : null
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_keys)
}

resource "aws_secretsmanager_secret_rotation" "this" {
  count = var.enable_rotation ? 1 : 0

  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = var.rotation_lambda_arn
  rotation_rules {
    automatically_after_days = var.automatically_after_days
  }
}