provider "aws" {
  region = "eu-central-1"
}

module "eks_complete_setup" {
  source = "./path-to-this-module" # Replace with the actual module path

  eks_cluster_name             = "example-eks-cluster"
  eks_cluster_iam_role_name    = "example-eks-cluster-role"
  eks_ng_iam_role_name         = "example-nodegroup-role"
  auto_scaling_iam_policy_name = "example-autoscaling-policy"
  eks_kms_key_name             = "example-eks-kms-key"

  efs_token_name               = "example-efs-token"
  efs_sg_name                  = "example-efs-sg"
  efs_csi_driver_iam_role_name = "example-efs-csi-role"
  efs_csi_iam_policy_name      = "example-efs-csi-policy"

  vpc_id             = "vpc-0abcd1234efgh5678"
  cidr_block         = "10.1.0.0/16"
  private_subnet_ids = ["subnet-0123abcd4567efgh", "subnet-9876wxyz6543lkjh"]

  eks_cluster_version         = "1.32"
  eks_endpoint_private_access = true
  eks_endpoint_public_access  = false

  ng_name                     = "example-ng"
  ng_instance_types           = ["t3.medium"]
  ng_desired_size             = 2
  ng_min_size                 = 1
  ng_max_size                 = 4
  ng_ami_type                 = "AL2_x86_64"
  ng_capacity_type            = "ON_DEMAND"
  cluster_autoscaler_version  = "9.46.6"
  efs_csi_driver_version      = "3.1.8"
  force_update_efs_csi        = false
  force_recreate_pods_efs_csi = false

  eks_iam_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  node_group_iam_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  k8s_map_roles = [
    {
      rolearn  = "arn:aws:iam::123456789012:role/devops-role",
      username = "devops:{{SessionName}}",
      groups   = ["system:masters"]
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "example-eks"
    Owner       = "devops-team"
  }
}
