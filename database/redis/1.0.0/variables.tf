# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "replication_group_id" {
  description = "The replication group identifier. This parameter is stored as a lowercase string"
  type        = string
}

variable "description" {
  description = "A user-created description for the replication group"
  type        = string
}

variable "node_type" {
  description = "The compute and memory capacity of the nodes in the node group (shard)"
  type        = string
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this replication group"
  type        = string
}

variable "subnet_group_name" {
  description = "The name of the subnet group to be used for the replication group"
  type        = string
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest for the cluster"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}

# ==============================================================================
# HIGH AVAILABILITY CONFIGURATION
# ==============================================================================

variable "automatic_failover_enabled" {
  description = "Whether automatic failover is enabled for the replication group"
  type        = bool
  default     = true
}

variable "num_cache_clusters" {
  description = "The number of cache clusters that are part of this replication group"
  type        = number
  default     = 2

  validation {
    condition     = var.num_cache_clusters >= 2
    error_message = "Number of cache clusters must be at least 2 for high availability."
  }
}

variable "cluster_mode" {
  description = "The cluster mode for the replication group"
  type        = string
  default     = null
}

# ==============================================================================
# NETWORK CONFIGURATION
# ==============================================================================

variable "port" {
  description = "The port number on which each member of the replication group accepts connections"
  type        = number
  default     = 6379
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the replication group"
  type        = list(string)
  default     = []
}

# ==============================================================================
# SECURITY CONFIGURATION
# ==============================================================================

variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit between application and cache nodes"
  type        = bool
  default     = true
}

variable "redis_auth_token" {
  description = "The password used to access a password protected server"
  type        = string
  default     = null
  sensitive   = true
}

variable "kms_key_id" {
  description = "The ARN of the KMS key used to encrypt the data at rest"
  type        = string
  default     = null
}

# ==============================================================================
# MAINTENANCE CONFIGURATION
# ==============================================================================

variable "apply_immediately" {
  description = "Whether to apply changes immediately or during the next maintenance window"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Whether to automatically upgrade to minor version updates during maintenance window"
  type        = bool
  default     = false
}

# ==============================================================================
# LOGGING CONFIGURATION
# ==============================================================================

variable "log_delivery_configurations" {
  description = "A list of log delivery configurations for the replication group"
  type = list(object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  }))
  default = []
}