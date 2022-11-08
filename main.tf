locals {
  enabled                     = var.enabled
  namespace                   = var.namespace
  insecure                    = var.insecure
  ca_data                     = base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data))
  eks_cluster_id              = try(data.aws_eks_cluster.cluster.id)
  argocd_endpoint             = one(data.aws_eks_cluster.cluster[*].endpoint)
}


data "aws_eks_cluster" "cluster" {
  count = local.enabled ? 1 : 0
  
  name = var.eks_cluster_id
}
