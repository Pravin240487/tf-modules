output "id" {
  description = "The ID of the subnet"
  value       = aws_subnet.this.id
}

output "arn" {
  description = "The ARN of the subnet"
  value       = aws_subnet.this.arn
}