# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "db_instance_name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "kms_key_id" {
  description = "The KMS key ID for encrypting the RDS instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group to associate with the RDS instance"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "parameter_group_name" {
  description = "The name of the RDS parameter group to associate with the RDS instance"
  type        = string
}

variable "parameter_group_family" {
  description = "The family of the RDS parameter group (e.g., 'postgres15', 'mysql8.0')"
  type        = string
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
}

variable "backup_window" {
  description = "Preferred backup window (in UTC, format: hh24:mi-hh24:mi)"
  type        = string
}

variable "maintenance_window" {
  description = "Preferred maintenance window (in UTC, format: ddd:hh24:mi-ddd:hh24:mi)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the RDS instance"
  type        = map(string)
}

# ==============================================================================
# DATABASE ENGINE CONFIGURATION
# ==============================================================================

variable "engine" {
  description = "The database engine to use for the RDS instance"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The version of the database engine to use"
  type        = string
  default     = "16.3"
}

variable "db_name" {
  description = "The name of the database to create within the RDS instance"
  type        = string
  default     = "masterdb"
}

variable "username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "masteruser"
}

# ==============================================================================
# STORAGE CONFIGURATION
# ==============================================================================

variable "allocated_storage" {
  description = "The amount of storage (in GiB) to allocate for the RDS instance"
  type        = number
}

variable "max_allocated_storage" {
  description = "The maximum amount of storage (in GiB) to allow for the RDS instance"
  type        = number
}

variable "storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
}

variable "storage_encrypted" {
  description = "Whether to enable storage encryption for the RDS instance"
  type        = bool
  default     = true
}

# ==============================================================================
# HIGH AVAILABILITY & BACKUP
# ==============================================================================

variable "multi_az" {
  description = "Whether to create a Multi-AZ RDS instance"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Whether to copy tags to snapshots of the RDS instance"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection for the RDS instance"
  type        = bool
  default     = true
}

# ==============================================================================
# MAINTENANCE & UPDATES
# ==============================================================================

variable "auto_minor_version_upgrade" {
  description = "Whether to enable auto minor version upgrades for the RDS instance"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Whether to apply changes immediately or during the next maintenance window"
  type        = bool
  default     = false
}

# ==============================================================================
# PERFORMANCE & MONITORING
# ==============================================================================

variable "performance_insights_enabled" {
  description = "Whether to enable Performance Insights for the RDS instance"
  type        = bool
  default     = true
}

variable "performance_insights_kms_key_id" {
  description = "The KMS key ID for encrypting Performance Insights data"
  type        = string
  default     = null
}

variable "monitoring_interval" {
  description = "The interval (in seconds) for enhanced monitoring of the RDS instance"
  type        = number
  default     = 60
}

variable "rds_monitoring_role_arn" {
  description = "The ARN of the IAM role for RDS monitoring"
  type        = string
  default     = null
}

variable "enabled_logs" {
  description = "A list of log types to enable for the RDS instance"
  type        = list(string)
  default     = ["postgresql", "upgrade"]
}

# ==============================================================================
# NETWORK CONFIGURATION
# ==============================================================================

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible"
  type        = bool
  default     = false
}

# ==============================================================================
# PARAMETER GROUP CONFIGURATION
# ==============================================================================

variable "parameter_group_description" {
  description = "A description for the RDS parameter group"
  type        = string
  default     = "RDS Parameter Group"
}

variable "parameters" {
  description = "A list of parameters to set for the RDS instance"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string, "pending-reboot") # Default to 'pending-reboot' if not specified
  }))
  default = []
}

# ==============================================================================
# DEPRECATED VARIABLES (Legacy Support)
# ==============================================================================

variable "environment" {
  description = "[DEPRECATED] The environment for which the RDS instance is being created (e.g., dev, staging, prod)"
  type        = string
  default     = null
}

variable "region" {
  description = "[DEPRECATED] The AWS region where the RDS instance will be deployed"
  type        = string
  default     = null
}

variable "region_suffix" {
  description = "[DEPRECATED] The region suffix to append to resource names (e.g., us-east-1, eu-west-1)"
  type        = string
  default     = null
}

variable "project_version" {
  description = "[DEPRECATED] The version of the project for which the RDS instance is being created"
  type        = string
  default     = null
}