variable "origin" {
  type        = string
  description = "The origin domain name for the CloudFront distribution (e.g., your S3 bucket or load balancer)."
}

variable "aliases" {
  type        = list(string)
  default     = []
  description = "A list of alternate domain names (CNAMEs) for this CloudFront distribution."
}

variable "comment" {
  type        = string
  default     = "Terraformed"
  description = "A comment about the CloudFront distribution, useful for identification."
}

variable "web_acl_id" {
  type        = string
  default     = null
  description = "The ID of the Web ACL (Access Control List) to associate with the CloudFront distribution."
}

variable "ipv6" {
  type        = bool
  default     = false
  description = "Specifies whether IPv6 is enabled for the CloudFront distribution."
}

variable "price_class" {
  type        = string
  default     = "PriceClass_All"
  description = "The price class for the CloudFront distribution. Options are 'PriceClass_100', 'PriceClass_200', 'PriceClass_All'."
}

#--------
# Origin
#--------

variable "origin_keepalive_timeout" {
  type        = number
  default     = 5
  description = "The keep-alive timeout in seconds for connections to the origin."
}

variable "origin_read_timeout" {
  type        = number
  default     = 30
  description = "The read timeout in seconds for responses from the origin."
}

#-----------------------
# Default Cache Behavior
#-----------------------

variable "default_allowed_methods" {
  type        = list(string)
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "The list of allowed HTTP methods for the default cache behavior."
}

variable "default_cached_methods" {
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
  description = "The list of HTTP methods that CloudFront caches for the default cache behavior."
}

variable "default_cache_policy_id" {
  type        = string
  default     = ""
  description = "The ID of the cache policy to use for the default cache behavior."
}

variable "default_origin_request_policy_id" {
  type        = string
  default     = ""
  description = "The ID of the origin request policy to use for the default cache behavior."
}

variable "default_response_headers_policy_id" {
  type        = string
  default     = ""
  description = "The ID of the response headers policy to use for the default cache behavior."
}

variable "default_viewer_protocol_policy" {
  type        = string
  default     = "redirect-to-https"
  description = "The viewer protocol policy for the default cache behavior."
}

variable "default_min_ttl" {
  type        = number
  default     = 0
  description = "The minimum TTL (Time to Live) in seconds for the default cache behavior."
}

variable "default_default_ttl" {
  type        = number
  default     = 0
  description = "The default TTL (Time to Live) in seconds for the default cache behavior."
}

variable "default_max_ttl" {
  type        = number
  default     = 0
  description = "The maximum TTL (Time to Live) in seconds for the default cache behavior."
}
variable "viewer_request_function_arn" {
  type    = string
  default = ""
  description = "CloudFront Function VERSIONED/qualified ARN (must include :version), in us-east-1"
}

variable "viewer_response_function_arn" {
  type    = string
  default = ""
  description = "Lambda@Edge VERSIONED/qualified ARN (must include :version), in us-east-1"
}

variable "origin_request_lambda_arn" {
  description = "Lambda@Edge VERSIONED/qualified ARN (must include :version), in us-east-1"
  type        = string
  default     = ""
}

variable "origin_request_include_body" {
  type    = bool
  default = false
  description = "Whether to include the body in requests sent to the origin."
}


#------------
# Certificate
#------------

variable "acm_certificate_arn" {
  type        = string
  default     = null
  description = "The ARN of the ACM certificate to associate with the CloudFront distribution."
}

variable "cloudfront_default_certificate" {
  type        = bool
  default     = true
  description = "Specifies whether CloudFront should use the default certificate or the ACM certificate."
}

#-----------------------
# Ordered Cache Behavior
#-----------------------

variable "ordered_cache_behavior" {
  type = list(object({
    path_pattern               = optional(string, "/*.png")
    allowed_methods            = optional(list(string), ["GET", "HEAD"])
    cached_methods             = optional(list(string), ["GET", "HEAD"])
    cache_policy_id            = optional(string, "CachingOptimized")
    origin_request_policy_id   = optional(string, "Managed-AllViewer")
    response_headers_policy_id = optional(string, "Managed-CORS-With-Preflight")
    min_ttl                    = optional(number, 0)
    default_ttl                = optional(number, 0)
    max_ttl                    = optional(number, 0)
    compress                   = optional(bool, false)
    viewer_protocol_policy     = optional(string, "redirect-to-https")
  }))
  default     = []
  description = "A list of ordered cache behaviors that specify how CloudFront handles requests for specific paths."
}

variable "tags" {
  description = "Map of tags to assign to the resource."
  type        = map(string)
}

#------------
# Environment
#------------

variable "environment" {
  type        = string
  description = "The environment for the CloudFront distribution (e.g., 'dev', 'prod')."
}

#-------
# Logs
#-------

variable "log_retention_in_days" {
  type        = number
  default     = 90
  description = "The number of days to retain access logs for the CloudFront distribution."
}

variable "log_output_format" {
  type        = string
  default     = "json"
  description = "The format for the CloudFront access logs (either 'json' or 'common-log-format')."
}

variable "log_type" {
  type        = string
  default     = "ACCESS_LOGS"
  description = "The type of logs to be generated for the CloudFront distribution (e.g., 'ACCESS_LOGS')."
}

#--------------
# Origin Access
#--------------

variable "enableOriginAccessControl" {
  type        = bool
  default     = false
  description = "Specifies whether to enable origin access control for the CloudFront distribution."
}

variable "oac_description" {
  type        = string
  default     = "Terraformed"
  description = "A description for the origin access control configuration."
}

variable "oac_origin_type" {
  type        = string
  default     = "s3"
  description = "The type of the origin for the CloudFront distribution (e.g., 's3' or 'custom')."
}

variable "oac_signing_behavior" {
  type        = string
  default     = "always"
  description = "The signing behavior for the origin access control ('always' or 'never')."
}

variable "oac_signing_protocol" {
  type        = string
  default     = "sigv4"
  description = "The signing protocol for the origin access control ('sigv4' for AWS Signature Version 4)."
}

#--------------
# Role ARN
#--------------

variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role to be used by the CloudFront distribution for accessing AWS resources."
}
# variable "logging_bucket_name" {
#   type        = string
#   description = "The name of the S3 bucket where CloudFront logs will be stored."
# }
variable "cf_enabled" {
  type        = bool
  default     = true
  description = "Whether the distribution is enabled to accept end user requests for content"
}
variable "default_root_object" {
  type        = string
  default     = ""
  description = "The default root object that CloudFront returns when a viewer requests the root URL of the distribution."
}
variable "cf_logging_prefix" {
  type        = string
  default     = "cloudfront/"
  description = "The prefix for the CloudFront logs stored in the S3 bucket."

}
variable "cf_logging_include_cookies" {
  type        = bool
  default     = false
  description = "Whether to include cookies in the CloudFront access logs."

}
variable "origin_protocol_policy" {
  type        = string
  default     = "https-only"
  description = "The protocol policy for the origin, either 'http-only', 'https-only', or 'match-viewer'."

}
variable "origin_ssl_protocols" {
  type        = list(string)
  default     = ["TLSv1.2"]
  description = "The SSL protocols that CloudFront uses to connect to the origin."

}
variable "ssl_support_method" {
  type        = string
  default     = "sni-only"
  description = "The SSL support method for the CloudFront distribution, either 'sni-only' or 'vip'."

}
variable "minimum_protocol_version" {
  type        = string
  default     = "TLSv1.2_2021"
  description = "The minimum SSL/TLS protocol version that CloudFront uses to communicate with viewers."

}
variable "kms_key_ids" {
  type        = string
  default     = ""
  description = "The KMS key ID for encrypting the CloudFront distribution's data at rest."

}