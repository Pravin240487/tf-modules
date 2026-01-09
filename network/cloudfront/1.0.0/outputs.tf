output "distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.id
}

output "distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.arn
}

output "domain_name" {
  description = "The domain name assigned by CloudFront (e.g., dxxxxx.cloudfront.net)"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "hosted_zone_id" {
  description = "The hosted zone ID for use with Route 53 alias records"
  value       = aws_cloudfront_distribution.this.hosted_zone_id
}

output "status" {
  description = "The current status of the distribution (e.g., Deployed)"
  value       = aws_cloudfront_distribution.this.status
}

output "last_modified_time" {
  description = "Timestamp of the last modification"
  value       = aws_cloudfront_distribution.this.last_modified_time
}

output "etag" {
  description = "The ETag of the distribution’s configuration"
  value       = aws_cloudfront_distribution.this.etag
}

output "in_progress_validation_batches" {
  description = "Number of invalidation batches in progress"
  value       = aws_cloudfront_distribution.this.in_progress_validation_batches
}
