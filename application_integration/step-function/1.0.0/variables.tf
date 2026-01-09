# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "name" {
  description = "The name of the Step Function state machine"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that Step Function will assume"
  type        = string
}

variable "definition" {
  description = "The Amazon States Language definition of the Step Function state machine"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Step Function state machine"
  type        = map(string)
}

# ==============================================================================
# LOGGING CONFIGURATION
# ==============================================================================

variable "enable_logging" {
  description = "Whether to enable logging for the Step Function state machine"
  type        = bool
  default     = true
}

variable "log_level" {
  description = "The logging level for the Step Function state machine (e.g., 'ALL', 'ERROR', 'FATAL')"
  type        = string
  default     = "ALL"
}

variable "include_execution_data" {
  description = "Whether to include execution data in the logs"
  type        = bool
  default     = true
}

variable "log_destination" {
  description = "The destination for the logs (e.g., CloudWatch Log Group ARN)"
  type        = string
}

# ==============================================================================
# TRACING CONFIGURATION
# ==============================================================================

variable "enable_tracing" {
  description = "Whether to enable X-Ray tracing for the Step Function state machine"
  type        = bool
  default     = false
}