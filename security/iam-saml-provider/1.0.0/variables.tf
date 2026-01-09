variable "saml_metadata_document" {
  description = "The SAML metadata document for the SAML provider"
  type        = string
}

variable "saml_provider_name" {
  description = "The name of the SAML provider"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the SAML provider"
  type        = map(string)
}