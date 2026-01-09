output "eks_iam_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  value       = module.eks_cluster_iam_role.arn
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_certificate_authority" {
  description = "The certificate authority data for the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.certificate_authority
}

output "ng_arn" {
  description = "The ARN of the EKS node group."
  value       = module.node_group.arn
}

output "ng_id" {
  description = "The ID of the EKS node group."
  value       = module.node_group.id
}

output "ng_resources" {
  description = "The resources associated with the EKS node group."
  value       = module.node_group.resources
}

output "ng_status" {
  description = "The status of the EKS node group."
  value       = module.node_group.status
}

output "efs_sg_id" {
  description = "The security group ID for the EFS."
  value       = module.efs.efs_sg_id
}

output "efs_file_id" {
  description = "The file system ID for the EFS."
  value       = module.efs.efs_file_id
}

