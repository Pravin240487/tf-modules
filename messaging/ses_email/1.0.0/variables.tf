variable "emails" {
  description = "A list of email addresses to verify in SES"
  type        = list(string)
}

variable "ses_email_identity_policy" {
  description = "A list of IAM policies (in JSON) for each SES email identity"
  type        = list(string)
}