output "arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "id" {
  description = "The ID of the target group"
  value       = aws_lb_target_group.this.id
}

output "name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.this.name
}

output "load_balancer_arn" {
  description = "The ARN of the load balancer associated with the target group"
  value       = aws_lb_target_group.this.load_balancer_arns
}
