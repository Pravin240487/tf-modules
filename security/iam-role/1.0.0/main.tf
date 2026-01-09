resource "aws_iam_role" "this" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  count      = length(var.iam_role_policy_attachments)
  role       = aws_iam_role.this.name
  policy_arn = var.iam_role_policy_attachments[count.index]

}