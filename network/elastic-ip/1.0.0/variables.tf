variable "elastic_ip_name" {
  description = "The name of the Elastic IP"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Elastic IP"
  type        = map(string)
}