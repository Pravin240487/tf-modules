variable "secret_description" {
  description = "Description of the secret"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "secret_keys" {
  description = "Map of key-value pairs to store in the secret"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "KMS key ARN to encrypt the secret. If not provided, AWS managed key will be used"
  type        = string
  default     = null
}

variable "enable_rotation" {
  description = "Whether to enable automatic rotation for this secret"
  type        = bool
  default     = false
}

variable "rotation_lambda_arn" {
  description = "ARN of the Lambda function that can rotate this secret. Required when enable_rotation is true"
  type        = string
  default     = null
}

variable "automatically_after_days" {
  description = "Number of days between automatic rotations"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to the secret"
  type        = map(string)
  default     = {}
}
