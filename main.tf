locals {
  enabled                     = module.this.enabled
  namespace                   = module.this["namespace"]
  insecure                    = var.insecure
  ca_data                     = base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data))
  eks_cluster_id              = one(data.aws_eks_cluster.cluster[*].id)
  argocd_endpoint             = one(data.aws_eks_cluster.cluster[*].endpoint)
}


data "aws_eks_cluster" "cluster" {
  count = local.enabled ? 1 : 0
  
  name = var.eks_cluster_id
}

output "z" {
  value = base64decode(data.aws_eks_cluster.cluster[*].certificate_authority[0].data)
}

output "zz" {
  value = base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[*].data))
}

output "zzzz" {
  value = base64decode(one(data.aws_eks_cluster.cluster[0]))
}

output "zzzzzx" {
  value = base64decode(one(data.aws_eks_cluster.cluster[*]))
}

output "xz" {
  value = base64decode(data.aws_eks_cluster.cluster[0])
}

output "xvz" {
  value = base64decode(data.aws_eks_cluster.cluster[*])
}

output "bb" {
  value = data.aws_eks_cluster.cluster[*]
}

output "bbb" {
  value = data.aws_eks_cluster.cluster[0]
}