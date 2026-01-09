variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which the target group is listening"
  type        = number
  default     = 80
}

variable "vpc_id" {
  description = "The VPC ID where the target group is located"
  type        = string
}

variable "healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 3
}

variable "interval" {
  description = "The approximate amount of time between health checks of an individual target"
  type        = number
  default     = 40
}

variable "matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200-499"
}

variable "path" {
  description = "The destination for health checks on the targets"
  type        = string
  default     = "/"
}

variable "unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 3
}

variable "timeout" {
  description = "The amount of time to wait when receiving a response from a target"
  type        = number
  default     = 30
}

variable "enable_stickiness" {
  description = "Whether to enable stickiness for the target group"
  type        = bool
  default     = false
}

variable "stickiness_type" {
  description = "The type of stickiness to use for the target group"
  type        = string
  default     = "lb_cookie"
}

variable "stickiness_cookie_duration" {
  description = "The duration of the stickiness cookie in seconds"
  type        = number
  default     = 3600 # 1 hour
}

variable "protocol" {
  description = "The protocol used by the target group"
  type        = string
  default     = "HTTPS"
}

variable "tags" {
  description = "A map of tags to assign to the target group"
  type        = map(string)
}
