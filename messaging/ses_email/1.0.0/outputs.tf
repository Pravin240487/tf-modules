output "ses_email_identity" {
  description = "The list of verified SES email identities"
  value       = [for e in aws_ses_email_identity.example : e.email]
}