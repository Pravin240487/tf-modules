output "envoy_instance_ids" {
  description = "List of Envoy instance IDs in the Auto Scaling Group"
  value       = data.aws_instances.envoy.ids
}

output "envoy_instance_id" {
  description = "Primary Envoy instance ID (first instance in the ASG)"
  value       = length(data.aws_instances.envoy.ids) > 0 ? data.aws_instances.envoy.ids[0] : null
}

output "envoy_private_ips" {
  description = "List of Envoy instance private IPs in the Auto Scaling Group"
  value       = data.aws_instances.envoy.private_ips
}

output "envoy_private_ip" {
  description = "Primary Envoy instance private IP (first instance in the ASG)"
  value       = length(data.aws_instances.envoy.private_ips) > 0 ? data.aws_instances.envoy.private_ips[0] : null
}

output "envoy_security_group_id" {
  value = aws_security_group.envoy_sg.id
}

output "nlb_arn" {
  value = aws_lb.envoy_nlb.arn
}

output "nlb_dns_name" {
  value = aws_lb.envoy_nlb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.envoy_tg.arn
}

output "vpc_endpoint_service_id" {
  value = aws_vpc_endpoint_service.envoy_service.id
}

output "vpc_endpoint_service_name" {
  value = aws_vpc_endpoint_service.envoy_service.service_name
}

output "asg_id" {
  description = "Auto Scaling Group ID"
  value       = aws_autoscaling_group.envoy.id
}

output "asg_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.envoy.arn
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.envoy.id
}

output "launch_template_arn" {
  description = "Launch Template ARN"
  value       = aws_launch_template.envoy.arn
}

output "iam_role_arn" {
  description = "IAM Role ARN for Envoy EC2 instances (CloudWatch Logs)"
  value       = module.envoy_iam_role.arn
}

output "iam_instance_profile_name" {
  description = "IAM Instance Profile name attached to Envoy instances"
  value       = aws_iam_instance_profile.envoy.name
}
