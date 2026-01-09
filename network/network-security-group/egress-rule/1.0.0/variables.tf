variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

variable "name" {
  description = "The name of the egress rule"
  type        = string
}

variable "description" {
  description = "The description of the egress rule"
  type        = string
}

variable "cidr_ipv4" {
  description = "value of the CIDR IPv4 for the egress rule"
  type        = string
  default     = null
}

variable "referenced_security_group_id" {
  description = "value of the referenced security group ID to allow ingress traffic from"
  type        = string
  default     = null
}

variable "ip_protocol" {
  description = "value of the IP protocol for the egress rule"
  type        = string
}

variable "tags" {
  description = "value of the tags for the egress rule"
  type        = map(string)
}
