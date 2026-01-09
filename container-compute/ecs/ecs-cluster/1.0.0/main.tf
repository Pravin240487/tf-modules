resource "aws_ecs_cluster" "this" {
  name = var.name

  setting {
    name  = var.setting_name
    value = var.container_insights
  }

  tags = var.tags
}