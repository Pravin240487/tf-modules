output "name" {
  description = "value of the IAM role name"
  value       = aws_iam_role.this.name
}

output "arn" {
  description = "value of the IAM role ARN"
  value       = aws_iam_role.this.arn
}

output "id" {
  description = "value of the IAM role ID"
  value       = aws_iam_role.this.arn
}