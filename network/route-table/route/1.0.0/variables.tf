variable "route_table_id" {
  description = "The ID of the route table to associate with the route."
  type        = string
}

variable "destination_cidr_block" {
  description = "The destination CIDR block for the route."
  type        = string
}

variable "gateway_id" {
  description = "The ID of the gateway to use for the route."
  type        = string
  default     = null
}

variable "nat_gateway_id" {
  description = "The ID of the NAT gateway to use for the route."
  type        = string
  default     = null
}