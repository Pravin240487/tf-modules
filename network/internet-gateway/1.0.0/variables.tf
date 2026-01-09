variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "internet_gateway_name" {
  description = "The name of the internet gateway."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the internet gateway."
  type        = map(string)
}