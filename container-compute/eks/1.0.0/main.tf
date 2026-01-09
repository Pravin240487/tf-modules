################################################################################################
#EKS Cluster
module "eks_cluster_iam_role" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = var.eks_cluster_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  iam_role_policy_attachments = var.eks_iam_role_policy_attachments
  tags                        = var.tags
}
module "kms_key" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/kms/1.0.0"

  key_name = var.eks_kms_key_name

  kms_key_policy = {
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowEKSClusterAccess",
        Effect = "Allow",
        Principal = {
          AWS = module.eks_cluster_iam_role.arn
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowSpecificNodeGroupAccess",
        Effect = "Allow",
        Principal = {
          AWS = module.node_group.ng_iam_role_arn
        },
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowForTheRoot",
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action = [
          "kms:*"
        ],
        Resource = "*"
      }
    ]
  }
  tags = var.tags
}


resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = module.eks_cluster_iam_role.arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = var.eks_endpoint_private_access
    endpoint_public_access  = var.eks_endpoint_public_access
  }
  encryption_config {
    provider {
      key_arn = module.kms_key.kms_key_arn
    }
    resources = ["secrets"]
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types
  tags                      = var.tags
}
################################################################################################
#EKS Node Group
module "node_group" {
  source                                 = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ng/1.0.0"
  cluster_autoscaler_version             = var.cluster_autoscaler_version
  eks_cluster_name                       = var.eks_cluster_name
  private_subnet_ids                     = var.private_subnet_ids
  ng_name                                = var.ng_name
  ng_desired_size                        = var.ng_desired_size
  ng_max_size                            = var.ng_max_size
  ng_min_size                            = var.ng_min_size
  ng_instance_types                      = var.ng_instance_types
  ng_ami_type                            = var.ng_ami_type
  eks_ng_iam_role_name                   = var.eks_ng_iam_role_name
  auto_scaling_iam_policy_name           = var.auto_scaling_iam_policy_name
  ng_capacity_type                       = var.ng_capacity_type
  node_group_iam_role_policy_attachments = var.node_group_iam_role_policy_attachments
  tags                                   = var.tags

}
###################### aws_auth - k8s config map ######################
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(concat([
      {
        rolearn  = module.node_group.ng_iam_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups = [
          "system:bootstrappers",
          "system:nodes"
        ]
      }
    ], var.k8s_map_roles))
  }
  depends_on = [aws_eks_cluster.eks_cluster]
}
################################################################################################
data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
######################## ODIC for IRSA ##############
data "aws_caller_identity" "current" {}
data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks_cluster.name
}
# EFS CSI Driver + IRSA + RBAC
module "efs_csi_driver" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = var.efs_csi_driver_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = aws_iam_openid_connect_provider.eks.arn
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "${replace(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:efs-csi-controller-sa"
        }
      }
    }]
  })
  tags = var.tags
}

module "efs_csi_iam_policy" {
  source               = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"
  iam_policy_name      = var.efs_csi_iam_policy_name
  iam_policy_name_desc = "EKS EFS CSI Driver IAM Policy"
  iam_policy_statements = [
    {
      "Effect" : "Allow",
      "Action" : [
        "elasticfilesystem:*",
      ],
      "Resource" : [module.efs.efs_sg_arn]
    }
  ]
  tags = var.tags
}
resource "aws_iam_role_policy_attachment" "efs_csi_driver_policy" {
  role       = module.efs_csi_driver.name
  policy_arn = module.efs_csi_iam_policy.arn
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0afd10a7e"] # Amazon root CA1 thumbprint

  tags = {
    Name = "${var.eks_cluster_name}-eks-oidc"
  }
}
resource "kubernetes_service_account" "efs_csi_controller" {
  metadata {
    name      = "efs-csi-controller-sa"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.efs_csi_driver.arn
    }
  }
}
resource "helm_release" "efs_csi_driver" {
  name          = "aws-efs-csi-driver"
  repository    = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  chart         = "aws-efs-csi-driver"
  version       = var.efs_csi_driver_version
  namespace     = "kube-system"
  force_update  = var.force_update_efs_csi
  recreate_pods = var.force_recreate_pods_efs_csi

  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }
  set {
    name  = "controller.serviceAccount.name"
    value = kubernetes_service_account.efs_csi_controller.metadata[0].name
  }

  depends_on = [kubernetes_service_account.efs_csi_controller]
}
########## Role binding #################################
resource "kubernetes_cluster_role" "efs_csi_controller_role" {
  metadata {
    name = "efs-csi-controller-role"
  }

  rule {
    api_groups = [""]
    resources  = ["persistentvolumes", "nodes", "pods"]
    verbs      = ["get", "list", "watch", "create", "delete", "patch", "update"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses", "volumeattachments"]
    verbs      = ["get", "list", "watch", "create", "delete", "patch", "update"]
  }

  rule {
    api_groups = ["coordination.k8s.io"]
    resources  = ["leases"]
    verbs      = ["create", "get", "list", "update"]
  }
}

resource "kubernetes_cluster_role_binding" "efs_csi_controller_binding" {
  metadata {
    name = "efs-csi-controller-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.efs_csi_controller_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.efs_csi_controller.metadata[0].name
    namespace = "kube-system"
  }
}
################################################################################################
# EFS Provisioner
module "efs" {
  source             = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/efs/1.0.0"
  efs_token_name     = var.efs_token_name
  efs_sg_name        = var.efs_sg_name
  vpc_id             = var.vpc_id
  cidr_block         = var.cidr_block
  private_subnet_ids = var.private_subnet_ids
  tags               = var.tags
  depends_on         = [module.node_group]

}
