output "sqs_queue_id" {
  description = "The ID of the primary SQS queue."
  value       = aws_sqs_queue.sqs.id
}

output "sqs_queue_arn" {
  description = "The ARN of the primary SQS queue."
  value       = aws_sqs_queue.sqs.arn
}

output "sqs_queue_url" {
  description = "The URL of the primary SQS queue."
  value       = aws_sqs_queue.sqs.url
}

output "dlq_queue_id" {
  description = "The ID of the dead-letter queue (DLQ), if created."
  value       = aws_sqs_queue.dlq[*].id
}

output "dlq_queue_arn" {
  description = "The ARN of the dead-letter queue (DLQ), if created."
  value       = aws_sqs_queue.dlq[*].arn

}
output "dlq_queue_url" {
  description = "The URL of the dead-letter queue (DLQ), if created."
  value       = aws_sqs_queue.dlq[*].url
}

output "sqs_name" {
  description = "The name of the primary SQS queue."
  value       = aws_sqs_queue.sqs.name
}
