variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "The JSON policy that grants an entity permission to assume the role"
  type        = string
}

variable "iam_role_policy_attachments" {
  description = "List of policy ARNs to attach to the IAM role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "values of the IAM role tags"
  type        = map(string)
}