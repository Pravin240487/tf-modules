variable "service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "service_security_group_name" {
  description = "The name of the security group for the ECS service."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster."
  type        = string
}

variable "task_definition_id" {
  description = "The ID of the ECS task definition."
  type        = string
}

variable "desired_count" {
  description = "The desired number of tasks in the ECS service."
  type        = number
  default     = 1
}

variable "subnets" {
  description = "List of subnet IDs for the ECS service."
  type        = list(string)
}

variable "load_balancers" {
  description = "List of load balancers to attach to the ECS service."
  type = list(object({
    target_group_arn = string
    container_name   = string
    container_port   = number
  }))
  default = []
}

variable "vpc_id" {
  description = "The ID of the VPC where the ECS service will be deployed."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the ECS service."
  type        = map(string)
}

### Auto Scale ###

variable "autoscaling" {
  description = "Enable or disable autoscaling for the ECS service."
  type        = bool
  default     = false
}

variable "min_capacity" {
  description = "Minimum number of tasks in the ECS service."
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks in the ECS service."
  type        = number
  default     = 2
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
  default     = "value"
}

variable "cpu_target_value" {
  description = "Target value for CPU utilization."
  type        = number
  default     = 50 
}

variable "cpu_scale_in_cooldown" {
  description = "Cooldown period after scaling in (in seconds)."
  type        = number
  default     = 300
}

variable "cpu_scale_out_cooldown" {
  description = "Cooldown period after scaling out (in seconds)."
  type        = number
  default     = 120
}

variable "memory_target_value" {
  description = "Target value for memory utilization."
  type        = number
  default     = 50 
}

variable "memory_scale_in_cooldown" {
  description = "Cooldown period after scaling in (in seconds)."
  type        = number
  default     = 300
}

variable "memory_scale_out_cooldown" {
  description = "Cooldown period after scaling out (in seconds)."
  type        = number
  default     = 120
}