module "cloudfront" {
  source = "s3::https://my-bucket.s3.amazonaws.com/modules.zip//cloudfront/1.0.0"

  origin              = "myapp.s3.amazonaws.com"
  acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abc123"
  aliases             = ["cdn.myapp.com"]
  comment             = "CloudFront for myapp"
  environment         = "prod"
  price_class         = "PriceClass_100"

  default_allowed_methods            = ["GET", "HEAD"]
  default_cached_methods             = ["GET", "HEAD"]
  default_cache_policy_id            = "Managed-CachingOptimized"
  default_origin_request_policy_id   = "Managed-AllViewer"
  default_response_headers_policy_id = "Managed-SecurityHeadersPolicy"
  default_viewer_protocol_policy     = "redirect-to-https"
  default_min_ttl                    = 0
  default_default_ttl                = 86400
  default_max_ttl                    = 31536000

  ordered_cache_behavior = [
    {
      path_pattern               = "/api/*"
      allowed_methods            = ["GET", "HEAD", "OPTIONS"]
      cached_methods             = ["GET", "HEAD"]
      cache_policy_id            = "Managed-CachingDisabled"
      origin_request_policy_id   = "Managed-AllViewerExceptHostHeader"
      response_headers_policy_id = "Managed-CORS-with-preflight"
      min_ttl                    = 0
      default_ttl                = 0
      max_ttl                    = 0
    }
  ]

  cloudfront_default_certificate = false
  ipv6                           = true
  web_acl_id                     = null

  # CloudWatch Logging Configuration
  log_retention_in_days = 14
  log_output_format     = "JSON"
  log_type              = "cdn"

  # Origin Access Control
  enableOriginAccessControl = true
  oac_description           = "OAC for secure S3 origin"
  oac_origin_type           = "s3"
  oac_signing_behavior      = "always"
  oac_signing_protocol      = "sigv4"

  # IAM Role for cross-account access (if needed)
  role_arn = "arn:aws:iam::123456789012:role/CloudFrontDeploymentRole"

  tags = {
    Application = "myapp"
    Environment = "prod"
    Owner       = "team-devops"
  }
}
