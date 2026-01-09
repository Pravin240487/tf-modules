resource "aws_kms_key" "kms" {
  description             = var.key_name
  enable_key_rotation     = var.enable_key_rotation
  deletion_window_in_days = var.deletion_window_in_days
  tags                    = var.tags
}

resource "aws_kms_key_policy" "kms" {
  key_id = aws_kms_key.kms.id
  policy = jsonencode(var.kms_key_policy)
}

resource "aws_kms_alias" "kms" {
  name          = "alias/${var.key_name}"
  target_key_id = aws_kms_key.kms.key_id
}