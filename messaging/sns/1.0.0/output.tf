output "id" {
  value       = aws_sns_topic.sns.id
  description = "The ID of the SNS topic."
}

output "arn" {
  value       = aws_sns_topic.sns.arn
  description = "The ARN of the SNS topic."
}
output "sns_topic_arn" {
  value       = aws_sns_topic_subscription.aws_sns_topic_subscription[*].arn
  description = "The ARN of the SNS topic subscription."
}
