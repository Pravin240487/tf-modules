# modules/site2site-vpn/outputs.tf

output "vpn_gateway_id" {
  description = "ID of the VPN Gateway"
  value       = aws_vpn_gateway.main.id
}

output "customer_gateway_id" {
  description = "ID of the Customer Gateway"
  value       = aws_customer_gateway.main.id
}

output "vpn_connection_id" {
  description = "ID of the VPN Connection"
  value       = aws_vpn_connection.main.id
}

output "vpn_connection_tunnel1_address" {
  description = "Public IP address of tunnel 1"
  value       = aws_vpn_connection.main.tunnel1_address
}

output "vpn_connection_tunnel2_address" {
  description = "Public IP address of tunnel 2"
  value       = aws_vpn_connection.main.tunnel2_address
}

output "vpn_connection_tunnel1_preshared_key" {
  description = "Pre-shared key for tunnel 1"
  value       = aws_vpn_connection.main.tunnel1_preshared_key
  sensitive   = true
}

output "vpn_connection_tunnel2_preshared_key" {
  description = "Pre-shared key for tunnel 2"
  value       = aws_vpn_connection.main.tunnel2_preshared_key
  sensitive   = true
}

output "customer_gateway_configuration" {
  description = "Configuration information for the customer gateway"
  value       = aws_vpn_connection.main.customer_gateway_configuration
  sensitive   = true
}
