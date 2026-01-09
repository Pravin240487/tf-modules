# ==============================================================================
# REQUIRED VARIABLES
# ==============================================================================

variable "web_acl_arn" {
  description = "The ARN of the WAFv2 Web ACL to associate with the resource"
  type        = string
}

variable "resource_arn" {
  description = "The ARN of the AWS resource to associate with the WAFv2 Web ACL (ALB, API Gateway, CloudFront, etc.)"
  type        = string
}