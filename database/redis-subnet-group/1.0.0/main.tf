# AWS ElastiCache Subnet Group for Redis clusters
# Defines the subnets where Redis cache nodes will be placed
resource "aws_elasticache_subnet_group" "this" {
  name        = var.name
  description = var.description
  subnet_ids  = var.subnet_ids
  
  tags = var.tags
}