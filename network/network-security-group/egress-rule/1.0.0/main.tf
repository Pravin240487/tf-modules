resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id            = var.security_group_id
  description                  = var.description
  cidr_ipv4                    = var.cidr_ipv4
  referenced_security_group_id = var.referenced_security_group_id
  ip_protocol                  = var.ip_protocol
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}