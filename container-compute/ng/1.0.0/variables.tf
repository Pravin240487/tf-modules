variable "cluster_autoscaler_version" {
  type        = string
  default     = "9.46.6"
  description = "The version of the cluster autoscaler."
}
variable "create_rbac" {
  type        = bool
  default     = true
  description = "Whether to create RBAC resources for the EKS cluster."
}
variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}
variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "The AWS region where the EKS cluster will be created."
}
variable "private_subnet_ids" {
  description = "A list of private subnet IDs."
  type        = list(string)
}
variable "ng_name" {
  description = "The name of the EKS node group."
  type        = string
}
variable "eks_ng_iam_role_name" {
  description = "The name of the IAM role for the EKS node group."
  type        = string
}
variable "auto_scaling_iam_policy_name" {
  description = "The name of the IAM policy for the auto-scaling group."
  type        = string

}
variable "node_group_iam_role_policy_attachments" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"]
  description = "A list of IAM policy ARNs to attach to the EKS node group IAM role."
}
variable "ng_instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "The instance types for the EKS node group."
}
variable "ng_desired_size" {
  type        = number
  default     = 2
  description = "The desired size for the EKS node group."
}
variable "ng_max_size" {
  type        = number
  default     = 4
  description = "The maximum size for the EKS node group."
}
variable "ng_min_size" {
  type        = number
  default     = 1
  description = "The minimum size for the EKS node group."
}
variable "ng_ami_type" {
  type        = string
  default     = "AL2_x86_64"
  description = "The AMI type for the EKS node group."
}
variable "ng_capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "The capacity type for the EKS node group."
}
variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
