# AWS ElastiCache Redis Replication Group for high-performance caching
resource "aws_elasticache_replication_group" "this" {
  # Basic cluster configuration
  replication_group_id = var.replication_group_id
  description         = var.description
  node_type           = var.node_type
  port                = var.port

  # High availability configuration
  automatic_failover_enabled = var.automatic_failover_enabled
  num_cache_clusters         = var.num_cache_clusters
  cluster_mode               = var.cluster_mode

  # Network configuration
  subnet_group_name  = var.subnet_group_name
  security_group_ids = var.security_group_ids

  # Security configuration
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.redis_auth_token
  kms_key_id                 = var.kms_key_id

  # Maintenance configuration
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  parameter_group_name       = var.parameter_group_name

  # Logging configuration
  dynamic "log_delivery_configuration" {
    for_each = var.log_delivery_configurations
    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }
  }

  tags = var.tags
}