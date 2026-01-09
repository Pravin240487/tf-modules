# modules/site2site-vpn/main.tf

# Virtual Private Gateway
resource "aws_vpn_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.vpn_gateway_name
    }
  )
}

# Customer Gateway
resource "aws_customer_gateway" "main" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = merge(
    var.tags,
    {
      Name = "${var.vpn_gateway_name}-cgw"
    }
  )
}

# VPN Connection
resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.main.id
  customer_gateway_id = aws_customer_gateway.main.id
  type                = "ipsec.1"
  static_routes_only  = var.static_routes_only

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.tunnel1_preshared_key
  tunnel2_preshared_key = var.tunnel2_preshared_key

  tags = merge(
    var.tags,
    {
      Name = "${var.vpn_gateway_name}-connection"
    }
  )
}

# Static Routes (if using static routing)
resource "aws_vpn_connection_route" "routes" {
  for_each = var.static_routes_only ? toset(var.destination_cidr_blocks) : toset([])

  destination_cidr_block = each.value
  vpn_connection_id      = aws_vpn_connection.main.id
}

# Enable VPN route propagation on route tables
resource "aws_vpn_gateway_route_propagation" "propagation" {
  for_each = toset(var.route_table_ids)

  vpn_gateway_id = aws_vpn_gateway.main.id
  route_table_id = each.value
}
