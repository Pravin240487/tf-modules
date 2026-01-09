output "arn" {
  description = "value of the ARN of the egress rule"
  value       = aws_vpc_security_group_egress_rule.this.arn
}

output "security_group_rule_id" {
  description = "value of the security group rule ID"
  value       = aws_vpc_security_group_egress_rule.this.id
}
