output "allocation_id" {
  description = "The allocation ID of the Elastic IP address."
  value       = aws_eip.this.id
}

output "public_ip" {
  description = "The public IP address of the Elastic IP."
  value       = aws_eip.this.public_ip
}

output "private_ip" {
  description = "The private IP address of the Elastic IP."
  value       = aws_eip.this.private_ip
}

output "public_dns" {
  description = "The public DNS name of the Elastic IP."
  value       = aws_eip.this.public_dns
}

output "id" {
  description = "The ID of the Elastic IP."
  value       = aws_eip.this.id
}