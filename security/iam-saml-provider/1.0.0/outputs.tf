output "saml_provider_arn" {
  description = "The ARN of the SAML provider"
  value       = aws_iam_saml_provider.this.arn
}

output "saml_provider_name" {
  description = "The name of the SAML provider"
  value       = aws_iam_saml_provider.this.name
}

output "saml_metadata_document" {
  description = "The SAML metadata document for the SAML provider"
  value       = aws_iam_saml_provider.this.saml_metadata_document
}