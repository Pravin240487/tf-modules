
# ==============================================================================
# AWS ElastiCache Redis Parameter Group Examples
# ==============================================================================

# Example 1: Production Redis Parameter Group (Performance Optimized)
module "production_redis_params" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//database/redis-parameter-group/1.0.0"

  name   = "prod-redis-performance-params"
  family = "redis7"

  parameters = [
    {
      name  = "maxmemory-policy"
      value = "allkeys-lru"
    },
    {
      name  = "timeout"
      value = "300"
    },
    {
      name  = "tcp-keepalive"
      value = "300"
    },
    {
      name  = "maxclients"
      value = "10000"
    },
    {
      name  = "notify-keyspace-events"
      value = "Ex"
    },
    {
      name  = "rdbcompression"
      value = "yes"
    },
    {
      name  = "rdbchecksum"
      value = "yes"
    },
    {
      name  = "save"
      value = "900 1 300 10 60 10000"
    }
  ]

  tags = {
    Environment = "production"
    Purpose     = "high-performance-cache"
    Team        = "platform"
    Monitoring  = "enabled"
  }
}