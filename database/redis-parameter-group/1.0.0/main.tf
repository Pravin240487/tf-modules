# AWS ElastiCache Redis Parameter Group for custom Redis configuration
resource "aws_elasticache_parameter_group" "this" {
  name   = var.name
  family = var.family

  # Dynamic parameter configuration for Redis tuning
  dynamic "parameter" {
    for_each = { for p in var.parameters : p.name => p }
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }

  tags = var.tags
}