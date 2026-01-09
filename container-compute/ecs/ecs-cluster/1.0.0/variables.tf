variable "name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "setting_name" {
  description = "The name of the setting for the ECS cluster"
  type        = string
  default     = "containerInsights"
}

variable "container_insights" {
  description = "Enable container insights for the ECS cluster"
  type        = string
  default     = "enhanced"
}

variable "tags" {
  description = "A map of tags to assign to the ECS cluster"
  type        = map(string)
}