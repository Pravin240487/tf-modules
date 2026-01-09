resource "aws_vpc_endpoint" "this" {
  vpc_id          = var.vpc_id
  service_name    = var.service_name
  route_table_ids = var.route_table_ids

  tags = merge(
    {
      Name = var.vpc_endpoint_name
    },
    var.tags
  )
}