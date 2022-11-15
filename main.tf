locals {
  enabled                     = module.this.enabled
  namespace                   = local.enabled ? var.namespace : null
  insecure                    = local.enabled ? var.insecure : null
  ca_data                     = base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data))
  eks_cluster_id              = one(data.aws_eks_cluster.cluster[*].id)
  argocd_endpoint             = one(data.aws_eks_cluster.cluster[*].endpoint)
}


data "aws_eks_cluster" "cluster" {
  count = local.enabled ? 1 : 0
  
  name = var.eks_cluster_id
}