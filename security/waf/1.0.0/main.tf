# ==============================================================================
# AWS WAFv2 Web ACL
# ==============================================================================
# Creates a WAFv2 Web Application Firewall to protect applications from common
# web exploits, DDoS attacks, and malicious traffic patterns

resource "aws_wafv2_web_acl" "this" {
  name        = var.name
  scope       = var.scope
  description = var.description

  # Default action when no rules match - allows traffic through by default
  default_action {
    allow {}
  }

  # Dynamic rule configuration - only processes enabled rules for better performance
  dynamic "rule" {
    for_each = { for idx, rule in var.waf_rules : idx => rule if rule.enabled }
    content {
      name     = rule.value.name
      priority = rule.value.priority

      # Action override configuration for AWS managed rule groups
      # Used to modify or disable specific rules within managed rule groups
      dynamic "override_action" {
        for_each = rule.value.action_type == "override" ? [1] : []
        content {
          # No action override - runs rules as defined by AWS
          dynamic "none" {
            for_each = rule.value.override_action == "none" ? [1] : []
            content {}
          }
          # Count mode - logs matches without blocking
          dynamic "count" {
            for_each = rule.value.override_action == "count" ? [1] : []
            content {}
          }
        }
      }

      # Action configuration for custom rules (allow, block, count)
      dynamic "action" {
        for_each = rule.value.action_type != "override" ? [1] : []
        content {
          # Allow traffic that matches this rule
          dynamic "allow" {
            for_each = rule.value.action_type == "allow" ? [1] : []
            content {}
          }
          # Block traffic that matches this rule
          dynamic "block" {
            for_each = rule.value.action_type == "block" ? [1] : []
            content {
              # Custom response configuration for blocked requests
              dynamic "custom_response" {
                for_each = rule.value.custom_response ? [1] : []
                content {
                  response_code            = rule.value.response_code
                  custom_response_body_key = rule.value.response_body_key
                }
              }
            }
          }
          # Count mode - logs matches for monitoring without blocking
          dynamic "count" {
            for_each = rule.value.action_type == "count" ? [1] : []
            content {}
          }
        }
      }

      # Statement configuration - defines the conditions for rule matching
      statement {
        # AWS Managed Rule Group Statement
        # Applies pre-configured rule sets maintained by AWS (e.g., Core Rule Set, Known Bad Inputs)
        dynamic "managed_rule_group_statement" {
          for_each = rule.value.statement_type == "managed_rule_group" ? [rule.value] : []
          content {
            name        = managed_rule_group_statement.value.rule_group_name
            vendor_name = managed_rule_group_statement.value.vendor_name

            # Override specific rules within the managed rule group
            dynamic "rule_action_override" {
              for_each = managed_rule_group_statement.value.excluded_rules
              content {
                name = rule_action_override.value
                action_to_use {
                  count {}
                }
              }
            }
          }
        }

        # Rate-Based Rule Statement
        # Blocks requests when they exceed a specified rate limit from the same IP
        dynamic "rate_based_statement" {
          for_each = rule.value.statement_type == "rate_based" ? [rule.value] : []
          content {
            limit                 = rate_based_statement.value.rate_limit
            aggregate_key_type    = rate_based_statement.value.aggregate_key_type
            evaluation_window_sec = rate_based_statement.value.evaluation_window_sec
          }
        }

        # Geographic Match Statement
        # Allows or blocks requests based on country of origin
        dynamic "geo_match_statement" {
          for_each = rule.value.statement_type == "geo_match" ? [rule.value] : []
          content {
            country_codes = geo_match_statement.value.country_codes
          }
        }

        # IP Set Reference Statement
        # Matches requests against a predefined list of IP addresses or CIDR blocks
        dynamic "ip_set_reference_statement" {
          for_each = rule.value.statement_type == "ip_set_reference" ? [rule.value] : []
          content {
            arn = try(ip_set_reference_statement.value.ip_set_arn, null) != null ? ip_set_reference_statement.value.ip_set_arn : aws_wafv2_ip_set.this.arn
          }
        }

        # Byte Match Statement
        # Searches for specific strings or patterns in request components
        dynamic "byte_match_statement" {
          for_each = rule.value.statement_type == "byte_match" ? [rule.value] : []
          content {
            search_string         = byte_match_statement.value.search_string
            positional_constraint = byte_match_statement.value.positional_constraint

            # Field to match configuration - specifies which part of the request to inspect
            field_to_match {
              # URI path component (e.g., /admin, /api/v1)
              dynamic "uri_path" {
                for_each = byte_match_statement.value.field_to_match == "uri_path" ? [1] : []
                content {}
              }
              # Query string parameters
              dynamic "query_string" {
                for_each = byte_match_statement.value.field_to_match == "query_string" ? [1] : []
                content {}
              }
              # Request body content
              dynamic "body" {
                for_each = byte_match_statement.value.field_to_match == "body" ? [1] : []
                content {}
              }
              # HTTP method (GET, POST, etc.)
              dynamic "method" {
                for_each = byte_match_statement.value.field_to_match == "method" ? [1] : []
                content {}
              }
              # Specific HTTP header
              dynamic "single_header" {
                for_each = byte_match_statement.value.field_to_match == "single_header" ? [1] : []
                content {
                  name = try(byte_match_statement.value.header_name, "user-agent")
                }
              }
            }

            # Text transformations to apply before matching (e.g., lowercase, URL decode)
            dynamic "text_transformation" {
              for_each = byte_match_statement.value.text_transformations
              content {
                priority = text_transformation.value.priority
                type     = text_transformation.value.type
              }
            }
          }
        }

        # Size Constraint Statement
        # Checks the size of specified request components against defined limits
        dynamic "size_constraint_statement" {
          for_each = rule.value.statement_type == "size_constraint" ? [rule.value] : []
          content {
            size                = size_constraint_statement.value.size
            comparison_operator = size_constraint_statement.value.comparison_operator

            # Field to match for size constraint evaluation
            field_to_match {
              # Request body size
              dynamic "body" {
                for_each = size_constraint_statement.value.size_constraint_field == "body" ? [1] : []
                content {}
              }
              # Query string size
              dynamic "query_string" {
                for_each = size_constraint_statement.value.size_constraint_field == "query_string" ? [1] : []
                content {}
              }
              # URI path size
              dynamic "uri_path" {
                for_each = size_constraint_statement.value.size_constraint_field == "uri_path" ? [1] : []
                content {}
              }
              # HTTP header size
              dynamic "single_header" {
                for_each = size_constraint_statement.value.size_constraint_field == "single_header" ? [1] : []
                content {
                  name = try(size_constraint_statement.value.size_header_name, "content-length")
                }
              }
            }

            # Text transformations for size constraint evaluation
            dynamic "text_transformation" {
              for_each = size_constraint_statement.value.text_transformations
              content {
                priority = text_transformation.value.priority
                type     = text_transformation.value.type
              }
            }
          }
        }

        # Custom AND Statement
        # Combines multiple conditions using logical AND operation
        dynamic "and_statement" {
          for_each = rule.value.statement_type == "custom" && rule.value.statement_nested_type == "and" ? [rule.value] : []
          content {
            # Nested statements within the AND condition
            dynamic "statement" {
              for_each = and_statement.value.custom_statements
              content {
                # Nested byte match statement within AND
                dynamic "byte_match_statement" {
                  for_each = statement.value.statement_type == "byte_match" ? [statement.value] : []
                  content {
                    search_string         = byte_match_statement.value.search_string
                    positional_constraint = byte_match_statement.value.positional_constraint

                    # Field to match for nested byte match
                    field_to_match {
                      dynamic "uri_path" {
                        for_each = byte_match_statement.value.field_to_match == "uri_path" ? [1] : []
                        content {}
                      }
                      dynamic "query_string" {
                        for_each = byte_match_statement.value.field_to_match == "query_string" ? [1] : []
                        content {}
                      }
                      dynamic "body" {
                        for_each = byte_match_statement.value.field_to_match == "body" ? [1] : []
                        content {}
                      }
                      dynamic "single_header" {
                        for_each = byte_match_statement.value.field_to_match == "single_header" ? [1] : []
                        content {
                          name = try(byte_match_statement.value.header_name, "user-agent")
                        }
                      }
                    }

                    # Text transformations for nested byte match
                    dynamic "text_transformation" {
                      for_each = byte_match_statement.value.text_transformations
                      content {
                        priority = text_transformation.value.priority
                        type     = text_transformation.value.type
                      }
                    }
                  }
                }

                # NOT Statement - inverts the result of the nested statement
                dynamic "not_statement" {
                  for_each = statement.value.statement_type == "not" ? [statement.value] : []
                  content {
                    statement {
                      # Geographic match statement within NOT (e.g., NOT from specific countries)
                      dynamic "geo_match_statement" {
                        for_each = not_statement.value.nested_statement.statement_type == "geo_match" ? [not_statement.value.nested_statement] : []
                        content {
                          country_codes = geo_match_statement.value.country_codes
                        }
                      }

                      # IP set reference statement within NOT (e.g., NOT from whitelist IPs)
                      dynamic "ip_set_reference_statement" {
                        for_each = not_statement.value.nested_statement.statement_type == "ip_set_reference" ? [not_statement.value.nested_statement] : []
                        content {
                          arn = try(ip_set_reference_statement.value.ip_set_arn, null) != null ? ip_set_reference_statement.value.ip_set_arn : aws_wafv2_ip_set.this.arn
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      # CloudWatch metrics and sampling configuration for monitoring rule performance
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = true
      }
    }
  }

  # Custom response bodies for blocked requests (e.g., maintenance page, error messages)
  dynamic "custom_response_body" {
    for_each = var.custom_response_bodies
    content {
      key          = custom_response_body.key
      content_type = custom_response_body.value.content_type
      content      = custom_response_body.value.content
    }
  }

  # Web ACL-level visibility configuration for overall monitoring
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.waf_metric_name
    sampled_requests_enabled   = true
  }

  tags = var.tags
}

# ==============================================================================
# WAFv2 Web ACL Logging Configuration
# ==============================================================================
# Enables logging of WAF decisions to CloudWatch for monitoring and analysis

resource "aws_wafv2_web_acl_logging_configuration" "this" {
  log_destination_configs = [aws_cloudwatch_log_group.this.arn]
  resource_arn            = aws_wafv2_web_acl.this.arn

  depends_on = [aws_wafv2_web_acl.this, aws_cloudwatch_log_group.this]
}

# ==============================================================================
# CloudWatch Log Group for WAF Logs
# ==============================================================================
# Stores WAF access logs with configurable retention and encryption

resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_days
  kms_key_id        = var.log_group_kms_key_id != null ? var.log_group_kms_key_id : null

  tags = var.tags
}

# ==============================================================================
# WAFv2 IP Set for Whitelist/Blacklist Management
# ==============================================================================
# Manages a collection of IP addresses or CIDR blocks for allow/deny rules

resource "aws_wafv2_ip_set" "this" {
  name               = var.ipset_name
  description        = var.ipset_description
  scope              = var.ipset_scope
  ip_address_version = var.ip_address_version
  addresses          = var.whitelist_ips

  tags = var.tags
}
