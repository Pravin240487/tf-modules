variable "vpc_id" {
  description = "The ID of the VPC where the endpoint will be created"
  type        = string
}

variable "vpc_endpoint_name" {
  description = "The name of the VPC endpoint"
  type        = string
}

variable "service_name" {
  description = "The name of the service for the VPC endpoint"
  type        = string
}

variable "route_table_ids" {
  description = "A list of route table IDs to associate with the VPC endpoint"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the VPC endpoint"
  type        = map(string)
}