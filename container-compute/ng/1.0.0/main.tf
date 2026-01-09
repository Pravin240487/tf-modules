module "node_group_iam_role" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = var.eks_ng_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  iam_role_policy_attachments = var.node_group_iam_role_policy_attachments
  tags                        = var.tags
}
module "auto_scaling_iam_policy" {
  source               = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"
  iam_policy_name      = var.auto_scaling_iam_policy_name
  iam_policy_name_desc = "policy for auto scaling"
  iam_policy_statements = [
    {
      "Effect" : "Allow",
      "Action" : [
        "autoscaling:*",
        "eks:Describe*",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Resource" : ["*"]
  }]
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "node_group_asg" {
  role       = module.node_group_iam_role.name
  policy_arn = module.auto_scaling_iam_policy.arn

}
resource "aws_eks_node_group" "node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.ng_name
  node_role_arn   = module.node_group_iam_role.arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.ng_desired_size
    max_size     = var.ng_max_size
    min_size     = var.ng_min_size
  }

  instance_types = var.ng_instance_types

  ami_type      = var.ng_ami_type
  capacity_type = var.ng_capacity_type

  tags = merge(var.tags, {
    "k8s.io/cluster-autoscaler/enabled" : "true"
    "k8s.io/cluster-autoscaler/${var.eks_cluster_name}" : "owned"
  })
}
######################## Auto Scaling ########################
resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.cluster_autoscaler_version

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.region
  }
  set {
    name  = "rbac.create"
    value = var.create_rbac
  }

  depends_on = [aws_eks_node_group.node_group]
}
