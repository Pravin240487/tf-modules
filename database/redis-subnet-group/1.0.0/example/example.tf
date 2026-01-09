# ==============================================================================
# AWS ElastiCache Redis Subnet Group Examples
# ==============================================================================

# Example 1: Production Multi-AZ Redis Subnet Group
module "production_redis_subnet_group" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//database/redis-subnet-group/1.0.0"

  name        = "prod-redis-subnet-group"
  description = "Production Redis subnet group with multi-AZ deployment"
  subnet_ids  = [
    "subnet-1a2b3c4d", # us-east-1a
    "subnet-5e6f7g8h", # us-east-1b
    "subnet-9i0j1k2l"  # us-east-1c
  ]

  tags = {
    Environment      = "production"
    Service         = "redis-cache"
    HighAvailability = "enabled"
    Team            = "platform"
    Backup          = "enabled"
  }
}