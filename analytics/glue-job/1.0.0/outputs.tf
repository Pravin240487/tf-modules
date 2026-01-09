output "arn" {
  description = "ARN of the Glue job"
  value       = aws_glue_job.this.arn
}

output "id" {
  description = "ID of the Glue job"
  value       = aws_glue_job.this.id
}
