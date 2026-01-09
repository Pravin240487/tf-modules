locals {
  # Defining sets of policy IDs used in cache behaviors
  cache_policy_names            = toset([for b in var.ordered_cache_behavior : b.cache_policy_id])
  origin_request_policy_names   = toset([for b in var.ordered_cache_behavior : b.origin_request_policy_id])
  response_headers_policy_names = toset([for b in var.ordered_cache_behavior : b.response_headers_policy_id])

  # Merging policies with the actual policy details
  cache_policy = [
    for b in var.ordered_cache_behavior : merge(b, {
      cache_policy_id = data.aws_cloudfront_cache_policy.this_[b.cache_policy_id].id
    })
  ]
  origin_request_policy = [
    for b in var.ordered_cache_behavior : merge(b, {
      origin_request_policy_id = data.aws_cloudfront_origin_request_policy.this_[b.origin_request_policy_id].id
    })
  ]
  response_headers_policy = [
    for b in var.ordered_cache_behavior : merge(b, {
      response_headers_policy_id = data.aws_cloudfront_response_headers_policy.this_[b.response_headers_policy_id].id
    })
  ]
}
#########################
provider "aws" {
  alias  = "useast1"
  region = "us-east-1"
  assume_role {
    role_arn = var.role_arn
  }
}
#########################
module "logging" {
  source      = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/s3/1.0.0"
  bucket_name = "${var.aliases[0]}-log"
  tags        = var.tags
}
data "aws_cloudfront_cache_policy" "this" {
  count = var.default_cache_policy_id != "" ? 1 : 0
  name  = var.default_cache_policy_id
}

data "aws_cloudfront_origin_request_policy" "this" {
  count = var.default_origin_request_policy_id != "" ? 1 : 0
  name  = var.default_origin_request_policy_id
}

data "aws_cloudfront_response_headers_policy" "this" {
  count = var.default_response_headers_policy_id != "" ? 1 : 0
  name  = var.default_response_headers_policy_id
}

data "aws_cloudfront_cache_policy" "this_" {
  for_each = local.cache_policy_names
  name     = each.key
}

data "aws_cloudfront_origin_request_policy" "this_" {
  for_each = local.origin_request_policy_names
  name     = each.key
}

data "aws_cloudfront_response_headers_policy" "this_" {
  for_each = local.response_headers_policy_names
  name     = each.key
}
##########################
resource "aws_cloudfront_distribution" "this" {
  aliases             = var.aliases
  comment             = var.comment
  web_acl_id          = var.web_acl_id
  enabled             = var.cf_enabled
  is_ipv6_enabled     = var.ipv6
  price_class         = var.price_class
  default_root_object = var.default_root_object
  # logging_config {
  #   include_cookies = var.cf_logging_include_cookies
  #   bucket          = "${var.aliases[0]}-log"
  #   prefix          = var.cf_logging_prefix
  # }

  origin {
    domain_name              = var.origin
    origin_id                = var.origin
    origin_access_control_id = var.enableOriginAccessControl ? aws_cloudfront_origin_access_control.this[0].id : null
    dynamic "custom_origin_config" {
      for_each = var.enableOriginAccessControl ? [] : [1] # Include only when OAC is false
      content {
        http_port                = 80
        https_port               = 443
        origin_keepalive_timeout = var.origin_keepalive_timeout
        origin_protocol_policy   = var.origin_protocol_policy
        origin_read_timeout      = var.origin_read_timeout
        origin_ssl_protocols     = var.origin_ssl_protocols
      }
    }
  }

  default_cache_behavior {
    allowed_methods            = var.default_allowed_methods
    cached_methods             = var.default_cached_methods
    target_origin_id           = var.origin
    cache_policy_id            = length(data.aws_cloudfront_cache_policy.this) > 0 ? try(data.aws_cloudfront_cache_policy.this[0].id, null) : null
    origin_request_policy_id   = length(data.aws_cloudfront_origin_request_policy.this) > 0 ? try(data.aws_cloudfront_origin_request_policy.this[0].id, null) : null
    response_headers_policy_id = length(data.aws_cloudfront_response_headers_policy.this) > 0 ? try(data.aws_cloudfront_response_headers_policy.this[0].id, null) : null
    viewer_protocol_policy     = var.default_viewer_protocol_policy
    min_ttl                    = var.default_min_ttl
    default_ttl                = var.default_default_ttl
    max_ttl                    = var.default_max_ttl

      # CloudFront Function - Viewer Request
  dynamic "function_association" {
    for_each = var.viewer_request_function_arn != "" ? [1] : []
    content {
      event_type   = "viewer-request"
      function_arn = var.viewer_request_function_arn
    }
  }

  # CloudFront Function - Viewer Response
  dynamic "function_association" {
    for_each = var.viewer_response_function_arn != "" ? [1] : []
    content {
      event_type   = "viewer-response"
      function_arn = var.viewer_response_function_arn
    }
  }

  # Lambda@Edge - Origin Request
  dynamic "lambda_function_association" {
    for_each = var.origin_request_lambda_arn != "" ? [1] : []
    content {
      event_type   = "origin-request"
      lambda_arn   = var.origin_request_lambda_arn
      include_body = var.origin_request_include_body
    }
  }

  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behavior
    content {
      path_pattern               = ordered_cache_behavior.value.path_pattern
      allowed_methods            = ordered_cache_behavior.value.allowed_methods
      cached_methods             = ordered_cache_behavior.value.cached_methods
      target_origin_id           = var.origin
      cache_policy_id            = lookup(local.cache_policy[ordered_cache_behavior.key], "cache_policy_id", null)
      origin_request_policy_id   = lookup(local.origin_request_policy[ordered_cache_behavior.key], "origin_request_policy_id", null)
      response_headers_policy_id = lookup(local.response_headers_policy[ordered_cache_behavior.key], "response_headers_policy_id", null)
      min_ttl                    = ordered_cache_behavior.value.min_ttl
      default_ttl                = ordered_cache_behavior.value.default_ttl
      max_ttl                    = ordered_cache_behavior.value.max_ttl
      compress                   = false
      viewer_protocol_policy     = "redirect-to-https"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "DE"]
    }

  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    cloudfront_default_certificate = var.cloudfront_default_certificate
    iam_certificate_id             = null
    minimum_protocol_version       = var.minimum_protocol_version
    ssl_support_method             = var.ssl_support_method
  }

  tags = var.tags
}
##################

resource "aws_cloudwatch_log_group" "cloudfront_logs" {
  provider          = aws.useast1
  name              = "qs-${var.environment}-${aws_cloudfront_distribution.this.id}-log"
  retention_in_days = var.log_retention_in_days
  kms_key_id        = var.kms_key_ids
  tags              = var.tags
}

resource "aws_cloudwatch_log_delivery_destination" "cloudwatch_log_group" {
  provider      = aws.useast1
  name          = "qs-${var.environment}-${aws_cloudfront_distribution.this.id}-log"
  output_format = var.log_output_format

  delivery_destination_configuration {
    destination_resource_arn = aws_cloudwatch_log_group.cloudfront_logs.arn
  }
}

resource "aws_cloudwatch_log_delivery_source" "cloudfront_logs" {
  provider     = aws.useast1
  name         = "qs-${var.environment}-${aws_cloudfront_distribution.this.id}-log"
  log_type     = var.log_type
  resource_arn = aws_cloudfront_distribution.this.arn
}

resource "aws_cloudwatch_log_delivery" "cloudfront_logs" {
  provider                 = aws.useast1
  delivery_source_name     = aws_cloudwatch_log_delivery_source.cloudfront_logs.name
  delivery_destination_arn = aws_cloudwatch_log_delivery_destination.cloudwatch_log_group.arn
}
##################
resource "aws_cloudfront_origin_access_control" "this" {
  count                             = var.enableOriginAccessControl ? 1 : 0
  description                       = var.oac_description
  name                              = var.origin
  origin_access_control_origin_type = var.oac_origin_type
  signing_behavior                  = var.oac_signing_behavior
  signing_protocol                  = var.oac_signing_protocol
}
