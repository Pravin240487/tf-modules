# ==============================================================================
# AWS ElastiCache Redis Examples
# ==============================================================================

# Example 1: Production Redis with High Security
module "production_redis" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//database/redis/1.0.0"

  # Basic configuration
  replication_group_id = "prod-redis-cluster"
  description         = "Production Redis cluster for application caching"
  node_type           = "cache.r6g.large"

  # High availability
  automatic_failover_enabled = true
  num_cache_clusters         = 3
  cluster_mode               = null

  # Network configuration
  subnet_group_name  = "prod-redis-subnet-group"
  security_group_ids = ["sg-prod-redis-12345"]
  port               = 6379

  # Security configuration
  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  redis_auth_token           = random_password.redis_auth_token.result
  kms_key_id                 = aws_kms_key.redis_encryption.arn

  # Maintenance configuration
  parameter_group_name       = "prod-redis-params"
  apply_immediately          = false
  auto_minor_version_upgrade = false

  # Comprehensive logging
  log_delivery_configurations = [
    {
      destination      = aws_cloudwatch_log_group.redis_slow_log.arn
      destination_type = "cloudwatch-logs"
      log_format       = "text"
      log_type         = "slow-log"
    }
  ]

  tags = {
    Environment = "production"
    Application = "web-cache"
    Team        = "platform"
    Backup      = "critical"
    Monitoring  = "enhanced"
  }
}