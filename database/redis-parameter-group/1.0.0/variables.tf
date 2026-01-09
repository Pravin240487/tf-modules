# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "name" {
  description = "The name of the Redis parameter group"
  type        = string
}

variable "family" {
  description = "The family of the Redis parameter group (e.g., redis7, redis6.x, redis5.0)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Redis parameter group"
  type        = map(string)
}

# ==============================================================================
# OPTIONAL VARIABLES
# ==============================================================================

variable "parameters" {
  description = "A list of Redis parameter name/value pairs for performance tuning"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}