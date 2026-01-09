# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "connection_name" {
  description = "Name of the Glue connection"
  type        = string
}

variable "connection_properties" {
  description = "A map of key-value pairs used as parameters for this connection. Supports JDBC, MongoDB, Kafka, and other connection types"
  type        = map(string)
  default     = {}

  validation {
    condition     = length(var.connection_properties) > 0
    error_message = "At least one connection property must be specified."
  }
}

variable "tags" {
  description = "Tags to apply to the Glue connection"
  type        = map(string)
}

# ==============================================================================
# OPTIONAL VARIABLES
# ==============================================================================

variable "physical_connection_requirements" {
  description = "Physical connection requirements for the Glue connection. Set to null to skip physical connection requirements"
  type = object({
    availability_zone      = string
    security_group_id_list = list(string)
    subnet_id              = string
  })
  default = null
}

# ==============================================================================
# DEPRECATED VARIABLES (For Backward Compatibility)
# ==============================================================================

variable "jdbc_connection_url" {
  description = "[DEPRECATED] Use connection_properties instead. JDBC connection URL for the Glue connection"
  type        = string
  default     = null
}

variable "secret_id" {
  description = "[DEPRECATED] Use connection_properties instead. Secret ID for the Glue connection"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "[DEPRECATED] Use physical_connection_requirements instead. Availability zone for the Glue connection"
  type        = string
  default     = null
}

variable "security_group_id_list" {
  description = "[DEPRECATED] Use physical_connection_requirements instead. List of security group IDs for the Glue connection"
  type        = list(string)
  default     = null
}

variable "subnet_id" {
  description = "[DEPRECATED] Use physical_connection_requirements instead. Subnet ID for the Glue connection"
  type        = string
  default     = null
}