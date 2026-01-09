variable "name" {
  description = "value of the security group name"
  type        = string
}

variable "description" {
  description = "value of the security group description"
  type        = string
  default     = "Security group for allowing traffic"
}

variable "vpc_id" {
  description = "value of the VPC ID"
  type        = string
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}