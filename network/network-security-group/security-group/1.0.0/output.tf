output "arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.this.arn
}

output "id" {
  description = "value of the security group ID"
  value       = aws_security_group.this.id
}