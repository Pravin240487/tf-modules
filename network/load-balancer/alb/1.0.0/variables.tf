variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or internet-facing"
  type        = bool
  default     = true
}
variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be created"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "client_keep_alive" {
  description = "Time in seconds to keep the client connection alive"
  type        = number
  default     = 3600
}

variable "idle_timeout" {
  description = "Idle timeout in seconds for the load balancer"
  type        = number
  default     = 60
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = true
}

variable "enable_access_logs" {
  description = "Enable access logs for the load balancer"
  type        = bool
  default     = false
}

variable "log_prefix" {
  description = "Log prefix for the alb logs"
  type        = string
  default     = ""
}

variable "access_logs_s3_bucket_id" {
  description = "value of the S3 bucket to store access logs"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the load balancer"
  type        = map(string)
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for the load balancer"
  type        = string
}

variable "ssl_policy" {
  description = "The SSL policy for the load balancer"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "enable_waf" {
  description = "Enable WAF association"
  type        = bool
  default     = false
}

variable "web_acl_arn" {
  description = "The ID of the WAFregional Web ACL to associate with the resource."
  type        = string
  default     = ""
}

### Security Group Variables

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Allow TLS inbound traffic and all outbound traffic"
}

### Security Group Ingress Rules Variables

variable "ingress_rule_name" {
  description = "Name of the ingress rule"
  type        = string
  default     = "Allow-443"
}

variable "ingress_rule_description" {
  description = "Description of the ingress rule"
  type        = string
  default     = "Allow HTTPS inbound traffic"
}

variable "ingress_rule_cidr_ipv4" {
  description = "CIDR IPv4 block for the ingress rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ingress_rule_from_port" {
  description = "Starting port for the ingress rule"
  type        = number
  default     = 443
}

variable "ingress_rule_to_port" {
  description = "Ending port for the ingress rule"
  type        = number
  default     = 443
}

variable "ingress_rule_ip_protocol" {
  description = "IP protocol for the ingress rule"
  type        = string
  default     = "tcp"
}

### Security Group HTTP Ingress Rules Variables

variable "ingress_rule_http_name" {
  description = "Name of the HTTP ingress rule"
  type        = string
  default     = "Allow-80"
}

variable "ingress_rule_http_description" {
  description = "Description of the HTTP ingress rule"
  type        = string
  default     = "Allow HTTP inbound traffic"
}

variable "ingress_rule_http_cidr_ipv4" {
  description = "CIDR IPv4 block for the HTTP ingress rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ingress_rule_http_from_port" {
  description = "Starting port for the HTTP ingress rule"
  type        = number
  default     = 80
}

variable "ingress_rule_http_to_port" {
  description = "Ending port for the HTTP ingress rule"
  type        = number
  default     = 80
}

variable "ingress_rule_http_ip_protocol" {
  description = "IP protocol for the HTTP ingress rule"
  type        = string
  default     = "tcp"
}

### Security Group Egress Rules Variables

variable "egress_rule_name" {
  description = "Name of the egress rule"
  type        = string
  default     = "Allow-All-Outbound"
}

variable "egress_rule_description" {
  description = "Description of the egress rule"
  type        = string
  default     = "Allow all outbound traffic"
}

variable "egress_rule_cidr_ipv4" {
  description = "CIDR IPv4 block for the egress rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "egress_rule_ip_protocol" {
  description = "IP protocol for the egress rule"
  type        = string
  default     = "-1"
}
