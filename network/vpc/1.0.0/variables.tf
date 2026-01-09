variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "value to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "value to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "flow_log_enabled" {
  description = "value to enable flow logs for the VPC"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS Key ID to encrypt the CloudWatch log group"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region where the VPC will be created"
  type        = string
}

variable "account_id" {
  description = "AWS account ID where the VPC will be created"
  type        = string
}

variable "iam_role_policy_attachments" {
  description = "List of policy ARNs to attach to the IAM role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "value to set tags for the VPC"
  type        = map(string)
}
