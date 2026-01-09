# Terraform AWS EKS Cluster with Node Group and EFS CSI Driver

This module deploys a full **Amazon EKS cluster** with:

- Cluster + Node Group IAM roles and policies
- EKS cluster with private-only endpoint
- Managed Node Group with autoscaling
- KMS key for secrets encryption
- EFS + EFS CSI Driver with IRSA (IAM Roles for Service Accounts)
- Helm installation for EFS CSI
- OIDC provider and service account binding
- Optional RBAC role bindings

---

## 📦 Module Structure

This module includes the following components:

- **IAM Roles:** EKS Cluster, Node Group, EFS CSI Driver
- **EKS Cluster:** Private endpoint with secrets encryption
- **Node Group:** Auto-scaling and flexible instance types
- **KMS:** Encryption key with proper access policies
- **EFS:** File system and mount targets
- **IRSA:** OIDC integration with service account annotation
- **Helm:** Deploys EFS CSI driver in `kube-system` namespace

---

## 🚀 Usage

```hcl
module "eks_complete_setup" {
  source = "./path-to-this-module"

  eks_cluster_name                = "example-eks-cluster"
  eks_cluster_iam_role_name      = "example-eks-cluster-role"
  eks_ng_iam_role_name           = "example-nodegroup-role"
  auto_scaling_iam_policy_name   = "example-autoscaling-policy"
  eks_kms_key_name               = "example-eks-kms-key"

  efs_token_name                 = "example-efs-token"
  efs_sg_name                    = "example-efs-sg"
  efs_csi_driver_iam_role_name  = "example-efs-csi-role"
  efs_csi_iam_policy_name       = "example-efs-csi-policy"

  vpc_id             = "vpc-0abcd1234efgh5678"
  cidr_block         = "10.1.0.0/16"
  private_subnet_ids = ["subnet-abc123", "subnet-def456"]

  eks_cluster_version           = "1.32"
  eks_endpoint_private_access   = true
  eks_endpoint_public_access    = false

  ng_name                       = "example-ng"
  ng_instance_types             = ["t3.medium"]
  ng_desired_size               = 2
  ng_min_size                   = 1
  ng_max_size                   = 4

  eks_iam_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]

  node_group_iam_role_policy_attachments = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

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
