variable "hosted_zone_name" {
  description = "The name of the hosted zone for the ACM certificate."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ACM certificate."
  type        = string
}

variable "subject_alternative_names" {
  description = "A list of additional domain names to be included in the certificate (Subject Alternative Names)."
  type        = list(string)
  default     = []
}

variable "hosted_private_zone" {
  description = "The name of the Route53 hosted zone."
  type        = string
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the ACM certificate."
  type        = map(string)
}