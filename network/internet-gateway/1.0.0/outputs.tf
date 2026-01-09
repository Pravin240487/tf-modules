output "id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.this.id
}

output "arn" {
  description = "The ARN of the internet gateway"
  value       = aws_internet_gateway.this.arn
}