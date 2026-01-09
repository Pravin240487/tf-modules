variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the NAT Gateway will be deployed"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the NAT Gateway"
  type        = map(string)
}