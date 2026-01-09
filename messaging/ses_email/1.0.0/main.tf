resource "aws_ses_email_identity" "example" {
  count = length(var.emails)

  email = var.emails[count.index]
}

resource "aws_ses_identity_policy" "example" {
  count    = length(aws_ses_email_identity.example)
  identity = aws_ses_email_identity.example[count.index].email
  name     = "AllowExternalSenders-${count.index}"
  policy   = var.ses_email_identity_policy[count.index]
}