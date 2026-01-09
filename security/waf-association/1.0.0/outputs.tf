output "web_acl_arn" {
  description = "The ARN of the associated WAFv2 Web ACL"
  value       = aws_wafv2_web_acl_association.this.web_acl_arn
}

output "resource_arn" {
  description = "The ARN of the resource associated with the WAFv2 Web ACL"
  value       = aws_wafv2_web_acl_association.this.resource_arn
}

output "association_id" {
  description = "The ID of the WAFv2 Web ACL association"
  value       = aws_wafv2_web_acl_association.this.id
}