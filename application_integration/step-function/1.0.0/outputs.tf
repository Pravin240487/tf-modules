output "name" {
  description = "The name of the Step Function state machine"
  value       = aws_sfn_state_machine.this.name
}

output "arn" {
  description = "The ARN of the Step Function state machine"
  value       = aws_sfn_state_machine.this.arn
}

output "role_arn" {
  description = "The ARN of the IAM role that Step Function will assume"
  value       = aws_sfn_state_machine.this.role_arn
}