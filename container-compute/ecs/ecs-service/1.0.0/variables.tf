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
