output "id" {
  description = "The ID of the listener rule."
  value       = aws_lb_listener_rule.this.id
}

output "arn" {
  description = "The ARN of the listener rule."
  value       = aws_lb_listener_rule.this.arn
}
