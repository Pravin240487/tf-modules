variable "iam_policy_name" {
  description = "IAM Policy name"
  type        = string
}

variable "iam_policy_name_desc" {
  description = "IAM Policy description"
  type        = string
}

variable "iam_policy_statements" {
  type        = list(any)
  description = "List of policy statements"
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)

}