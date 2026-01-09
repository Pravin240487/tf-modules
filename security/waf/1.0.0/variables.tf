# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "name" {
  description = "The name of the WAF Web ACL"
  type        = string
}

variable "waf_metric_name" {
  description = "The name of the CloudWatch metric for the WAF Web ACL"
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group for WAF logs"
  type        = string
}

variable "log_retention_days" {
  description = "The number of days to retain log events in the CloudWatch log group"
  type        = number
  default     = 90
}

# ==============================================================================
# WAF CONFIGURATION
# ==============================================================================

variable "scope" {
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
  type        = string
  default     = "CLOUDFRONT"

  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.scope)
    error_message = "Valid values for scope are 'CLOUDFRONT' or 'REGIONAL'."
  }
}

variable "description" {
  description = "Description of the WAF Web ACL"
  type        = string
  default     = "WAF Web ACL"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

# ==============================================================================
# LOGGING CONFIGURATION
# ==============================================================================

variable "log_group_kms_key_id" {
  description = "The ARN of the KMS key to use for encrypting the CloudWatch log group. If not provided, the log group will use AWS managed encryption."
  type        = string
  default     = null
}

# ==============================================================================
# WAF RULES CONFIGURATION
# ==============================================================================

variable "waf_rules" {
  description = <<-EOT
    List of WAF rules to apply. Each rule supports multiple statement types and actions.
    
    Supported statement types:
    - managed_rule_group: AWS/F5/Other managed rule groups
    - rate_based: Rate limiting rules
    - geo_match: Country/region based allow/block
    - ip_set_reference: IP whitelist/blacklist
    - byte_match: String/pattern matching
    - size_constraint: Request size limits
    - custom: Complex nested AND/OR/NOT statements
    
    For CKV_AWS_192 Log4j protection compliance, include:
    - AWSManagedRulesKnownBadInputsRuleSet with action_type = "override" and override_action = "none"
    - AWSManagedRulesCommonRuleSet with action_type = "override" and override_action = "none"
    - Ensure no excluded_rules that would disable Log4j protection
  EOT
  type = list(object({
    name           = string
    priority       = number
    enabled        = bool
    statement_type = string
    action_type    = string
    metric_name    = string

    # Override action for managed rules
    override_action = optional(string)

    # Custom response configuration
    custom_response   = optional(bool, false)
    response_code     = optional(number)
    response_body_key = optional(string)

    # Managed rule group specific
    vendor_name     = optional(string)
    rule_group_name = optional(string)
    excluded_rules  = optional(list(string), [])

    # Rate-based rule specific
    rate_limit            = optional(number)
    aggregate_key_type    = optional(string)
    evaluation_window_sec = optional(number)

    # Geo match specific
    country_codes = optional(list(string))

    # IP set reference specific
    ip_set_arn = optional(string)

    # Byte match specific
    search_string         = optional(string)
    positional_constraint = optional(string)
    field_to_match        = optional(string)
    header_name           = optional(string)
    text_transformations = optional(list(object({
      priority = number
      type     = string
    })), [])

    # Size constraint specific
    size                  = optional(number)
    comparison_operator   = optional(string)
    size_constraint_field = optional(string)
    size_header_name      = optional(string)

    # Custom statement specific (for complex AND/OR/NOT logic)
    statement_nested_type = optional(string)
    custom_statements = optional(list(object({
      statement_type        = string
      search_string         = optional(string)
      positional_constraint = optional(string)
      field_to_match        = optional(string)
      header_name           = optional(string)
      text_transformations = optional(list(object({
        priority = number
        type     = string
      })), [])
      country_codes = optional(list(string))
      ip_set_arn    = optional(string)
      nested_statement = optional(object({
        statement_type = string
        country_codes  = optional(list(string))
        ip_set_arn     = optional(string)
      }))
    })), [])
  }))
  default = []
}

variable "custom_response_bodies" {
  description = "Map of custom response body configurations for blocked requests"
  type = map(object({
    content_type = string
    content      = string
  }))
  default = {}
}

# ==============================================================================
# IP SET CONFIGURATION
# ==============================================================================

variable "ipset_name" {
  description = "The name of the IP set"
  type        = string
  default     = "whitelist-ip-set"
}

variable "ipset_description" {
  description = "Description of the IP set"
  type        = string
  default     = "IP set for whitelisted addresses"
}

variable "ipset_scope" {
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application"
  type        = string
  default     = "CLOUDFRONT"

  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.ipset_scope)
    error_message = "Valid values for ipset_scope are 'CLOUDFRONT' or 'REGIONAL'."
  }
}

variable "ip_address_version" {
  description = "Specify IPV4 or IPV6"
  type        = string
  default     = "IPV4"

  validation {
    condition     = contains(["IPV4", "IPV6"], var.ip_address_version)
    error_message = "Valid values for ip_address_version are 'IPV4' or 'IPV6'."
  }
}

variable "whitelist_ips" {
  description = "List of IP addresses or CIDR blocks to whitelist"
  type        = list(string)
  default     = []
}