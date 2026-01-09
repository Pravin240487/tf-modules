provider "aws" {
  region = "eu-central-1"
}

module "eks_node_group_autoscaler" {
  source = "./path-to-this-module" # Replace with actual path to your module

  eks_cluster_name             = "example-eks-cluster"
  region                       = "eu-central-1"
  private_subnet_ids           = ["subnet-0a1b2c3d4e5f6a7b8", "subnet-1a2b3c4d5e6f7g8h9"]
  ng_name                      = "example-ng"
  eks_ng_iam_role_name         = "example-ng-role"
  auto_scaling_iam_policy_name = "example-autoscaling-policy"

  node_group_iam_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  ]

  ng_instance_types          = ["t3.medium"]
  ng_desired_size            = 2
  ng_max_size                = 4
  ng_min_size                = 1
  ng_ami_type                = "AL2_x86_64"
  ng_capacity_type           = "ON_DEMAND"
  cluster_autoscaler_version = "9.46.6"
  create_rbac                = true

  tags = {
    Environment = "dev"
    Project     = "eks-nodegroup-autoscaler"
    Owner       = "devops-team"
  }
}
