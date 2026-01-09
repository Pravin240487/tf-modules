variable "name" {
  type        = string
  description = "value of the SNS topic name"
}

variable "tags" {
  description = "provide tags"
  type        = map(string)
}
variable "protocol" {
  type    = string
  default = "email"
}
variable "endpoint" {
  type    = list(string)
  default = []
}
variable "enable_sns_encryption" {
  description = "Enable encryption for SNS topic"
  type        = bool
  default     = false
}

variable "use_custom_kms_key" {
  description = "Use customer-managed KMS key for SNS"
  type        = bool
  default     = false
}

variable "sns_kms_key_arn" {
  description = "KMS key ARN for SNS encryption"
  type        = string
  default     = ""
}
variable "kms_master_key_id" {
  description = "KMS master key ID for SNS topic encryption"
  type        = string
  default     = "alias/kms/sns"

}

