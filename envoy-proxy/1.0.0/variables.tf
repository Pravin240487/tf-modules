variable "vpc_id" {
  description = "VPC ID where Envoy EC2 and NLB will live"
  type        = string
}

variable "envoy_subnet_id" {
  description = "Subnet ID for the Envoy EC2 instance"
  type        = string
}

variable "nlb_subnet_ids" {
  description = "List of subnet IDs for the internal NLB"
  type        = list(string)
}

variable "envoy_ami_id" {
  description = "AMI ID of the golden Envoy image (with Docker, certs, systemd)"
  type        = string
}

variable "envoy_instance_name" {
  description = "Name tag for the Envoy EC2 instance"
  type        = string
}

variable "nlb_name" {
  description = "Name for the internal NLB"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Envoy"
  type        = string
  default     = "t4g.micro"
}

variable "listener_port" {
  description = "Downstream TLS listener port for Envoy / NLB"
  type        = number
  default     = 8080
}

variable "admin_port" {
  description = "Envoy admin port"
  type        = number
  default     = 9901
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into Envoy instance"
  type        = string
}

variable "allowed_admin_cidr" {
  description = "CIDR allowed to reach Envoy admin port"
  type        = string
}

variable "envoy_config" {
  description = "Full Envoy YAML config to write to /etc/envoy/envoy.yaml"
  type        = string
  default     = ""
  nullable    = true
}

variable "endpoint_service_name" {
  description = "Name for the VPC endpoint service (optional, defaults to nlb_name-ep-svc)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "healthcheck_port" {
  description = "Port where Envoy exposes HTTP /health"
  type        = number
  default     = 8001
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "envoy-ssh-key"
}

variable "vpc_cidr_blocks" {
  description = "List of VPC CIDR blocks allowed to access Envoy via NLB (for healthcheck and listener ports)"
  type        = list(string)
  default     = []
}

variable "upstream_host" {
  description = "Upstream API hostname that Envoy will forward requests to"
  type        = string
}

variable "upstream_port" {
  description = "Upstream API port"
  type        = number
  default     = 443
}

variable "enable_public_ip" {
  description = "Enable public IP for the Envoy EC2 instance"
  type        = bool
  default     = false
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks allowed to access Envoy via NLB (for healthcheck and listener ports)"
  type        = list(string)
}

variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "instance_refresh_min_healthy_percentage" {
  description = "Minimum percentage of instances that must remain healthy during instance refresh"
  type        = number
  default     = 50
}

variable "cloudwatch_log_group_name" {
  description = "CloudWatch Log Group name for Envoy logs. If not provided, IAM role will still be created but with permissions for any log group"
  type        = string
  default     = null
  nullable    = true
}

variable "enable_target_group_stickiness" {
  description = "Enable target group stickiness so that user sessions go to the same instance (useful during deployments)"
  type        = bool
  default     = true
}

variable "stickiness_duration_seconds" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target. Valid range is 1-604800 seconds (7 days)"
  type        = number
  default     = 86400
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Type of the root EBS volume (e.g., gp3, gp2, io1)"
  type        = string
  default     = "gp3"
}