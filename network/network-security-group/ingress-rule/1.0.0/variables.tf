variable "security_group_id" {
  description = "value of the security group ID to which this rule will be applied"
  type        = string
}

variable "name" {
  description = "value of the name to apply to the ingress rule"
  type        = string
}

variable "description" {
  description = "value of the description to apply to the ingress rule"
  type        = string
}

variable "cidr_ipv4" {
  description = "value of the CIDR IPv4 range to allow ingress traffic from"
  type        = string
  default     = null
}

variable "referenced_security_group_id" {
  description = "value of the referenced security group ID to allow ingress traffic from"
  type        = string
  default     = null
}

variable "from_port" {
  description = "value of the starting port for the ingress rule"
  type        = number
}

variable "ip_protocol" {
  description = "value of the IP protocol for the ingress rule (e.g., tcp, udp, icmp)"
  type        = string
}

variable "to_port" {
  description = "value of the ending port for the ingress rule"
  type        = number
}

variable "tags" {
  description = "value of the tags to apply to the ingress rule"
  type        = map(string)
}