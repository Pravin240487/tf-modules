# Corrected WAF Module Configuration for CKV_AWS_192 Compliance
# This replaces your original waf_acls configuration

module "waf" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/waf/1.0.0"

  name            = "os-dev-ec1-waf-cf-v2"
  scope           = "CLOUDFRONT"
  description     = "os-dev-ec1-waf-cf-v2 with Log4j Protection"
  waf_metric_name = "os-dev-ec1-waf-cf-v2"
  log_group_name  = "/aws/wafv2/aws-waf-logs-os-v2"

  # CloudWatch Log Group configuration
  log_retention_days   = 365
  log_group_kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # Replace with your KMS key ARN

  waf_rules = [
    # AWS Managed Rule - Known Bad Inputs (Log4j Protection - REQUIRED for CKV_AWS_192)
    {
      name            = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      priority        = 0 # Highest priority for Log4j protection
      enabled         = true
      statement_type  = "managed_rule_group"
      vendor_name     = "AWS"
      rule_group_name = "AWSManagedRulesKnownBadInputsRuleSet"
      action_type     = "override"
      override_action = "none"
      excluded_rules  = [] # DO NOT exclude any rules for Log4j protection
      metric_name     = "AWSManagedRulesKnownBadInputsRuleSetMetric"
    },

    # Rate limiting rule
    {
      name                  = "os-dev-ec1-rate-limiting-v2"
      priority              = 1
      enabled               = true
      statement_type        = "rate_based"
      rate_limit            = 1000
      evaluation_window_sec = 300
      aggregate_key_type    = "IP"
      action_type           = "count"
      metric_name           = "os-dev-ec1-rate-limiting-v2"
    },

    # AWS Managed Rule - Common Rule Set (Additional Log4j Protection)
    {
      name            = "AWS-AWSManagedRulesCommonRuleSet"
      priority        = 2
      enabled         = true
      statement_type  = "managed_rule_group"
      vendor_name     = "AWS"
      rule_group_name = "AWSManagedRulesCommonRuleSet"
      action_type     = "override"
      override_action = "none"
      excluded_rules  = []
      metric_name     = "AWSManagedRulesCommonRuleSetMetric"
    },

    # F5 OWASP Managed Rule Group
    {
      name            = "F5-OWASP_Managed"
      priority        = 4
      enabled         = true
      statement_type  = "managed_rule_group"
      vendor_name     = "F5"
      rule_group_name = "OWASP_Managed"
      action_type     = "override"
      override_action = "none"
      excluded_rules = [
        "rule_SSRF_attempt_AllQueryArguments_Body",
        "rule_chmod_execution_attempt__Parameter__AllQueryArguments_Body",
        "rule_XSS_script_tag__Parameter__AllQueryArguments_Body",
        "rule_SQL_INJ_end_quote_UNION__Parameter__AllQueryArguments_Body",
        "rule_SQL_INJ_alter_column_AllQueryArguments_Body",
        "rule_SQLINJ___NoSQL_db_find____Parameter__AllQueryArguments_Body",
        "rule_document_cookie__Parameter__AllQueryArguments_Body",
        "rule_SQL_INJ_DROP_SCHEMA__Parameter__AllQueryArguments_Body",
        "rule_XML_External_Entity__XXE__injection_attempt__Content__AllQueryArguments_Body",
        "rule_Java_code_injection_java_lang_ClassLoader__Parameter__AllQueryArguments_Body",
        "rule_PHP_short_object_serialization_injection_attempt__Parameter__AllQueryArguments_Body",
        "rule_SQL_INJ_expressions_like__or_1_1__AllQueryArguments_Body",
        "rule_SQL_INJ_SELECT_DATABASE____Parameter__AllQueryArguments_Body",
        "rule_src_http___Parameter__AllQueryArguments_Body",
        "rule_SQL_INJ_UNION_SELECT_1_1__Parameter__AllQueryArguments_Body",
        "rule_valueOf__Parameter__AllQueryArguments_Body",
        "rule_div_tag__behavior__Parameter__AllQueryArguments_Body",
        "rule_Java_code_injection___org_apache_commons_collections_AllQueryArguments_Body"
      ]
      metric_name = "F5-OWASP_Managed"
    },

    # Custom AND statement (URL block with geo restriction)
    {
      name                  = "os-dev-ec1-url-block-waf-rule"
      priority              = 5
      enabled               = true
      statement_type        = "custom"
      statement_nested_type = "and"
      action_type           = "block"
      custom_response       = true
      response_code         = 403
      response_body_key     = "403-response-page"
      metric_name           = "os-dev-ec1-url-block-waf-rule"
      custom_statements = [
        {
          statement_type        = "byte_match"
          search_string         = "/api/appconnect/docs"
          positional_constraint = "CONTAINS"
          field_to_match        = "uri_path"
          text_transformations = [
            {
              priority = 0
              type     = "NONE"
            }
          ]
        },
        {
          statement_type = "not"
          nested_statement = {
            statement_type = "geo_match"
            country_codes  = ["IN"]
          }
        }
      ]
    },

    # Country allow rule
    {
      name           = "os-dev-ec1-country-restrictions-allow-waf-rule"
      priority       = 5
      enabled        = true
      statement_type = "geo_match"
      country_codes = [
        "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR", "DE", "GR",
        "VA", "HU", "IS", "IN", "IE", "IT", "LV", "LI", "LT", "LU", "MK", "MT", "MD", "MC", "ME", "NL",
        "NO", "PL", "PT", "RO", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "UA", "GB", "US"
      ]
      action_type = "allow"
      metric_name = "os-dev-ec1-country-restrictions-allow-waf-rule"
    },

    # Country block rule 1
    {
      name           = "os-dev-ec1-country-restrictions-block-waf-rule"
      priority       = 6
      enabled        = true
      statement_type = "geo_match"
      country_codes = [
        "AF", "DZ", "AS", "AD", "AO", "AI", "AQ", "AG", "AR", "AM", "AW", "AU", "AZ", "BS", "BH", "BD",
        "BB", "BY", "BZ", "BJ", "BM", "BT", "BO", "BQ", "BA", "BW", "BV", "BR", "IO", "BN", "KH", "CM",
        "CA", "CV", "KY", "CF", "TD", "CL", "CN", "CX", "CC", "CO", "KM", "CG", "CD", "CK", "CR", "CI",
        "CU", "CW"
      ]
      action_type       = "block"
      custom_response   = true
      response_code     = 403
      response_body_key = "403-response-page"
      metric_name       = "os-dev-ec1-country-restrictions-block-waf-rule"
    },

    # Country block rule 2
    {
      name           = "os-dev-ec1-country-restrictions-block-waf-rule-2"
      priority       = 7
      enabled        = true
      statement_type = "geo_match"
      country_codes = [
        "DJ", "DM", "DO", "EC", "EG", "SV", "GQ", "ER", "ET", "FK", "FO", "FJ", "GA", "GM", "GH", "GI",
        "GP", "GU", "GT", "GG", "GN", "GW", "GY", "HT", "HM", "VA", "HN", "HK", "IS", "ID", "IR", "IQ",
        "JP", "JE", "JO", "KZ", "KE", "KI", "KP", "KR", "KW", "GL", "GD", "IL", "JM", "LB", "LR", "RU",
        "KG", "LA"
      ]
      action_type       = "block"
      custom_response   = true
      response_code     = 403
      response_body_key = "403-response-page"
      metric_name       = "os-dev-ec1-country-restrictions-block-waf-rule-2"
    }
  ]

  # Custom response bodies
  custom_response_bodies = {
    "403-response-page" = {
      content_type = "TEXT_HTML"
      content      = "<html><body><h1>Access Denied</h1><p>Your request has been blocked by our security policy.</p></body></html>"
    }
  }

  # IP Set configuration
  ipset_name         = "os-dev-ec1-whitelist-ip-set"
  ipset_description  = "IP set for whitelisted addresses"
  ipset_scope        = "CLOUDFRONT"
  ip_address_version = "IPV4"
  whitelist_ips      = []

  tags = {
    Environment = "development"
    Application = "web-app"
    Owner       = "security-team"
    Purpose     = "waf-protection"
    Compliance  = "CKV_AWS_192"
  }
}
