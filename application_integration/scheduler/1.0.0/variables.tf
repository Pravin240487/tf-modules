variable "description" {
  description = "The description of the scheduler"
  type        = string
}

variable "group_name" {
  description = "The group name of the scheduler"
  type        = string
}

variable "name" {
  description = "The name of the scheduler"
  type        = string
}

variable "schedule_expression" {
  description = "The schedule expression of the scheduler"
  type        = string
}

variable "schedule_expression_timezone" {
  description = "The schedule expression timezone of the scheduler"
  type        = string
}

variable "state" {
  description = "The state of the scheduler"
  type        = string
}

variable "flexible_time_window" {
  description = "The flexible time window of the scheduler"
  type        = object({
    maximum_window_in_minutes = number
    mode                      = string
  })
}

variable "target" {
  description = "The target of the scheduler"
  type        = object({
    arn     = string
    role_arn = string
  })
}

variable "retry_policy" {
  description = "The retry policy of the scheduler"
  type        = object({
    maximum_event_age_in_seconds = number
    maximum_retry_attempts       = number
  })
}

variable "job_id" {
  description = "The job ID to be passed to the target"
  type        = string
}

variable "job_type" {
  description = "The job type to be passed to the target"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID to be passed to the target"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the scheduler resource"
  type        = map(string)
  default     = {}
}