resource "aws_iam_saml_provider" "this" {
  name                   = var.saml_provider_name
  saml_metadata_document = file(var.saml_metadata_document)
  tags                   = var.tags
}