output "ses_domain_identity_arn" {
  description = "The ARN of the SES domain identity"
  value       = aws_ses_domain_identity.domain_identity.arn
}

output "dkim_tokens" {
  description = "The DKIM tokens for the domain"
  value       = aws_ses_domain_dkim.dkim_identity.dkim_tokens
}

# output "route53_dkim_records" {
#   description = "The DKIM CNAME records created in Route 53"
#   value       = [for record in aws_route53_record.amazonses_dkim_record : record.fqdn]
# }

output "domain_verification_status" {
  description = "The status of the SES domain identity verification"
  value       = aws_ses_domain_identity_verification.domain_identity_verification.id
}