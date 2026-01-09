# AWS RDS Database Instance with comprehensive configuration
resource "aws_db_instance" "this" {
  # Basic database configuration
  identifier            = var.db_instance_name
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  db_name               = var.db_name

  # Engine and version settings
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class

  # Authentication and security
  username            = var.username
  password            = var.password
  kms_key_id          = var.kms_key_id
  storage_encrypted   = var.storage_encrypted
  deletion_protection = var.enable_deletion_protection

  # High availability and resilience
  multi_az              = var.multi_az
  skip_final_snapshot   = var.skip_final_snapshot
  copy_tags_to_snapshot = var.copy_tags_to_snapshot

  # Maintenance and updates
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately
  maintenance_window         = var.maintenance_window

  # Performance and monitoring
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = var.rds_monitoring_role_arn
  enabled_cloudwatch_logs_exports = var.enabled_logs

  # Storage configuration
  storage_type = var.storage_type

  # Network configuration
  db_subnet_group_name   = var.db_subnet_group_name
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = var.vpc_security_group_ids

  # Backup configuration
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  # Custom parameter group
  parameter_group_name = aws_db_parameter_group.this.name

  tags = var.tags
}

# Custom DB parameter group for engine-specific configuration
resource "aws_db_parameter_group" "this" {
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = var.parameter_group_description
  tags        = var.tags

  # Dynamic parameter configuration
  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}
