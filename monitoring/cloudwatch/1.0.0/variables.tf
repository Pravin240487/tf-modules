variable "log_group_name" {
  description = "The name of the CloudWatch log group."
  type        = string
}

variable "kms_key_id" {
  description = "The ARN of the KMS key to use for encrypting the log group. Leave empty if you do not wish to encrypt using KMS."
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "The number of days to retain log events in the log group."
  type        = number
  default     = 90
}

variable "tags" {
  description = "A map of tags to assign to the CloudWatch log group."
  type        = map(string)
}