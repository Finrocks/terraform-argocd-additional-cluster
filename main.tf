locals {
  enabled                     = module.this.enabled
  namespace                   = module.this.namespace
  insecure                    = var.insecure
  ca_data                     = base64decode(one(data.aws_eks_cluster.cluster[0].certificate_authority[0].data))
  eks_cluster_id              = one(data.aws_eks_cluster.cluster[*].id)
  argocd_endpoint             = one(data.aws_eks_cluster.cluster[*].endpoint)
}


data "aws_eks_cluster" "cluster" {
  count = local.enabled ? 1 : 0
  
  name = var.eks_cluster_id
}


output "ca_data" {
  value = local.ca_data
}