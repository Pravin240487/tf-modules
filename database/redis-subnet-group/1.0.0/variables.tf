# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "name" {
  description = "The name of the Redis subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the Redis subnet group. Must have at least 2 subnets for high availability"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the Redis subnet group"
  type        = map(string)
}

# ==============================================================================
# OPTIONAL VARIABLES
# ==============================================================================

variable "description" {
  description = "A description for the Redis subnet group. If not provided, defaults to 'Redis subnet group for {name}'"
  type        = string
  default     = null
}