resource "aws_iam_policy" "policy" {
  name        = var.iam_policy_name
  path        = "/"
  description = var.iam_policy_name_desc

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.iam_policy_statements
  })
  tags = var.tags
}