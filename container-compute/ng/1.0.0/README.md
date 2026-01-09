# EKS Node Group with Cluster Autoscaler Terraform Module

This module provisions an EKS managed node group, IAM roles, and deploys the Kubernetes Cluster Autoscaler via Helm.

## Features

- Creates an EKS managed node group
- Provisions and attaches IAM roles and policies required for EC2 and Auto Scaling
- Deploys [Cluster Autoscaler](https://github.com/kubernetes/autoscaler) using Helm
- Supports auto-discovery and scaling based on cluster metrics

## Usage

```hcl
module "eks_node_group_autoscaler" {
  source = "./path-to-this-module"

  eks_cluster_name                     = "my-eks-cluster"
  region                               = "eu-central-1"
  private_subnet_ids                   = ["subnet-abc123", "subnet-def456"]
  ng_name                              = "ng-01"
  eks_ng_iam_role_name                 = "eks-ng-role"
  auto_scaling_iam_policy_name        = "eks-autoscaling-policy"
  node_group_iam_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  ]
  ng_instance_types                    = ["t3.medium"]
  ng_desired_size                      = 2
  ng_max_size                          = 4
  ng_min_size                          = 1
  ng_ami_type                          = "AL2_x86_64"
  ng_capacity_type                     = "ON_DEMAND"
  cluster_autoscaler_version           = "9.46.6"
  create_rbac                          = true

  tags = {
    Environment = "production"
    Owner       = "platform-team"
  }
}
