variable "connections" {
  description = "List of connections to use for the Glue job"
  type        = list(string)
  default     = []
}

variable "default_arguments" {
  description = "Default arguments for the Glue job"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Description of the Glue job"
  type        = string
  default     = ""
}

variable "execution_class" {
  description = "Execution class for the Glue job (e.g., STANDARD, FLEX)"
  type        = string
  default     = "STANDARD"
}

variable "glue_version" {
  description = "Glue version to use for the job"
  type        = string
  default     = "2.0"
}

variable "job_run_queuing_enabled" {
  description = "Enable job run queuing for the Glue job"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "Maintenance window for the Glue job"
  type        = string
  default     = ""
}

variable "max_retries" {
  description = "Maximum number of retries for the Glue job"
  type        = number
  default     = 0
}

variable "name" {
  description = "Name of the Glue job"
  type        = string
}

variable "non_overridable_arguments" {
  description = "Non-overridable arguments for the Glue job"
  type        = map(string)
  default     = {}
}

variable "role_arn" {
  description = "ARN of the IAM role to use for the Glue job"
  type        = string
}

variable "security_configuration" {
  description = "Security configuration for the Glue job"
  type        = string
}

variable "timeout" {
  description = "Timeout for the Glue job in minutes"
  type        = number
}

variable "worker_type" {
  description = "Worker type for the Glue job (e.g., G.1X, G.2X)"
  type        = string
}

variable "command_name" {
  description = "Name of the command for the Glue job (e.g., glueetl, pyspark)"
  type        = string
}

variable "python_version" {
  description = "Python version to use for the Glue job"
  type        = string
}

variable "script_location" {
  description = "S3 location of the script for the Glue job"
  type        = string
  default     = ""
}

variable "max_concurrent_runs" {
  description = "Maximum number of concurrent runs for the Glue job"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for the Glue job (in DPU)"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the Glue job"
  type        = map(string)
}

variable "number_of_workers" {
  description = "Number of workers for the Glue job"
  type        = number
  default     = 0
  
}
