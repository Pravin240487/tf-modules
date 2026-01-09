variable "vpc_id" {
  description = "The ID of the VPC where the subnet will be created."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "availability_zone" {
  description = "The availability zone in which the subnet will be created."
  type        = string
  default     = null
}

variable "cidr_block" {
  description = "The CIDR block for the subnet."
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to assign a public IP address to instances launched in this subnet."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the subnet."
  type        = map(string)
}
