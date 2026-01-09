variable "key_name" {
  type        = string
  description = "Name for the KMS alias"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Enable automatic key rotation"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 30
  description = "Waiting period for key deletion"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the KMS key"
}

variable "kms_key_policy" {
  type        = any
  description = "IAM policy document for the KMS key"
}