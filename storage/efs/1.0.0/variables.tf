variable "efs_token_name" {
  type        = string
  description = "The name of the EFS token."
}

variable "efs_sg_name" {
  type        = string
  description = "The name of the security group for the EFS."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the EFS will be deployed."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of private subnet IDs where the EFS will be accessible."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the EFS resources."
}

variable "enable_encryption" {
  type        = bool
  description = "Whether to enable encryption for the EFS file system."
  default     = true
}
variable "kms_key_id" {
  default     = null
  description = "The KMS key ID to use for encrypting the EFS file system. If not provided, the default AWS managed key will be used."
  type        = string
}