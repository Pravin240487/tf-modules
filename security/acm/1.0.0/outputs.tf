output "id" {
  description = "The ID of the ACM certificate."
  value       = aws_acm_certificate.this.id
}

output "arn" {
  description = "The ARN of the ACM certificate."
  value       = aws_acm_certificate.this.arn
}

output "domain_name" {
  description = "The domain name of the ACM certificate."
  value       = aws_acm_certificate.this.domain_name
}