variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Force destroys all the objects within the s3 bucket"
  type        = bool
  default     = true
}


variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket access for this bucket"
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable or disable versioning for the S3 bucket"
  type        = string
  default     = "Enabled"
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for server-side encryption"
  type        = string
  default     = null
}

variable "bucket_policy" {
  description = "The policy to apply to the S3 bucket"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the S3 bucket"
  type        = map(string)
  default     = {}
}
