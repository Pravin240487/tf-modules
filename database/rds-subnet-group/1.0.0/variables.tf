# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to include in the DB subnet group (minimum 2 subnets in different AZs)"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the DB subnet group"
  type        = map(string)
}