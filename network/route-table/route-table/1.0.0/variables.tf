variable "vpc_id" {
  description = "The ID of the VPC to associate with the route table."
  type        = string
}

variable "route_table_name" {
  description = "The name of the route table."
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the route table."
  type        = map(string)
}