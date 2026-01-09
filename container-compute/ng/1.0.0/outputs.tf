output "arn" {
  description = "The ARN of the EKS node group."
  value       = aws_eks_node_group.node_group.arn
}

output "id" {
  description = "The ID of the EKS node group."
  value       = aws_eks_node_group.node_group.id
}

output "resources" {
  description = "The resources associated with the EKS node group."
  value       = aws_eks_node_group.node_group.resources
}
output "status" {
  value       = aws_eks_node_group.node_group.status
  description = "value of the EKS node group status"
}
output "ng_iam_role_arn" {
  value       = module.node_group_iam_role.arn
  description = "The ARN of the IAM role for the EKS node group."

}
