locals {
  enabled                     = var.enabled
  namespace                   = var.namespace
  insecure                    = var.insecure
  ca_data                     = base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data))
  ca_data1                     = one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data)
  ca_data2                     = one(data.aws_eks_cluster.cluster[*].certificate_authority[0])
  ca_data3                    = base64decode(data.aws_eks_cluster.cluster[*].certificate_authority.0.data)
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

output "ca_data1" {
  value = local.ca_data1
}

output "ca_data2" {
  value = local.ca_data2
}

output "ca_data3" {
  value = local.ca_data3
}
