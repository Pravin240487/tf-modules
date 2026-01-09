variable "cidr_block" {
  description = "cidr value is for the subnet"
  type        = string
  default     = "10.1.0.0/16"
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string

}
variable "private_subnet_ids" {
  description = "A list of private subnet IDs."
  type        = list(string)
}

variable "eks_cluster_iam_role_name" {
  description = "The name of the IAM role for the EKS cluster."
  type        = string
}
variable "eks_iam_role_policy_attachments" {
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
  description = "A list of IAM policy ARNs to attach to the EKS cluster IAM role."

}
variable "eks_cluster_version" {
  type        = string
  default     = "1.32"
  description = "The version of the EKS cluster."
}
variable "eks_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Whether the EKS cluster endpoint is accessible from within the VPC."
}
variable "eks_endpoint_public_access" {
  type        = bool
  default     = false
  description = "Whether the EKS cluster endpoint is accessible from the internet."
}
variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}
variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "A list of enabled cluster log types for the EKS cluster."
}
variable "environment" {
  description = "The environment for the EKS cluster (e.g., dev, prod)."
  type        = string

}
############ Node Group Variables ############
variable "cluster_autoscaler_version" {
  type        = string
  default     = "9.46.6"
  description = "The version of the cluster autoscaler."
}
variable "ng_name" {
  description = "The name of the EKS node group."
  type        = string

}
variable "ng_instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "value of the instance types for the EKS node group."
}
variable "ng_desired_size" {
  type        = number
  default     = 2
  description = "value of the desired size for the EKS node group."
}
variable "ng_max_size" {
  type        = number
  default     = 4
  description = "value of the maximum size for the EKS node group."
}
variable "ng_min_size" {
  type        = number
  default     = 1
  description = "value of the minimum size for the EKS node group."
}
variable "ng_ami_type" {
  type        = string
  default     = "AL2_x86_64"
  description = "value of the AMI type for the EKS node group."
}
variable "ng_capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "value of the capacity type for the EKS node group."
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
  default     = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
  description = "A list of IAM policy ARNs to attach to the EKS node group IAM role."
}
variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
variable "k8s_map_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default     = []
  description = "A list of Kubernetes map roles to be added to the aws-auth config map."
}
variable "efs_token_name" {
  description = "The name of the EFS token."
  type        = string

}
variable "efs_sg_name" {
  description = "The name of the security group for the EFS."
  type        = string

}
variable "efs_csi_driver_version" {
  type        = string
  default     = "3.1.8"
  description = "The version of the EFS CSI driver."
}
variable "efs_csi_driver_iam_role_name" {
  description = "The name of the IAM role for the EFS CSI driver."
  type        = string

}
variable "efs_csi_iam_policy_name" {
  description = "The name of the IAM policy for the EFS CSI driver."
  type        = string

}
variable "region" {
  type    = string
  default = "eu-central-1"
}
variable "force_update_efs_csi" {
  type        = bool
  default     = false
  description = "Whether to force update the EFS CSI driver."
}
variable "force_recreate_pods_efs_csi" {
  type        = bool
  default     = false
  description = "Whether to force recreate the pods using the EFS CSI driver."
}
variable "eks_kms_key_name" {
  description = "The name of the KMS key for the EKS cluster."
  type        = string

}
