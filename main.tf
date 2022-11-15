locals {
  enabled                     = module.this.enabled
  namespace                   = module.this["namespace"]
  insecure                    = local.enabled && var.insecure
  ca_data                     = local.enabled && base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data))
  eks_cluster_id              = local.enabled && one(data.aws_eks_cluster.cluster[*].id)
  argocd_endpoint             = local.enabled && one(data.aws_eks_cluster.cluster[*].endpoint)
}


data "aws_eks_cluster" "cluster" {
  count = local.enabled ? 1 : 0
  
  name = var.eks_cluster_id
}