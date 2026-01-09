# modules/site2site-vpn/variables.tf

variable "vpc_id" {
  description = "VPC ID where the VPN will be attached"
  type        = string
}

variable "vpn_gateway_name" {
  description = "Name for the Virtual Private Gateway"
  type        = string
  default     = "main-vpg"
}

variable "customer_gateway_ip" {
  description = "Public IP address of the customer gateway"
  type        = string
}

variable "customer_gateway_bgp_asn" {
  description = "BGP ASN of the customer gateway"
  type        = number
  default     = 65000
}

variable "destination_cidr_blocks" {
  description = "List of CIDR blocks to route through the VPN"
  type        = list(string)
  default     = []
}

variable "route_table_ids" {
  description = "List of route table IDs to propagate VPN routes to"
  type        = list(string)
  default     = []
}

variable "static_routes_only" {
  description = "Whether to use static routing only (true) or BGP (false)"
  type        = bool
  default     = false
}

variable "tunnel1_inside_cidr" {
  description = "CIDR block for tunnel 1 inside IP addresses"
  type        = string
  default     = null
}

variable "tunnel2_inside_cidr" {
  description = "CIDR block for tunnel 2 inside IP addresses"
  type        = string
  default     = null
}

variable "tunnel1_preshared_key" {
  description = "Pre-shared key for tunnel 1"
  type        = string
  default     = null
  sensitive   = true
}

variable "tunnel2_preshared_key" {
  description = "Pre-shared key for tunnel 2"
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

