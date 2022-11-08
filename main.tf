locals {
  enabled                     = var.enabled
  namespace                   = var.namespace
  insecure                    = var.insecure
  ca_data                     = base64decode(one(data.aws_eks_cluster.cluster[*].certificate_authority[0].data))
  account_id                  = one(data.aws_caller_identity.default[*].account_id)
  #eks_cluster_name            = one(data.aws_eks_cluster.default[*].id)
  eks_cluster_oidc_issuer_url = one(data.aws_eks_cluster.default[*].identity[0].oidc[0].issuer)
  argocd_endpoint             = one(data.aws_eks_cluster.default[*].endpoint)
  region                      = one(data.aws_region.default[*].name)
  currnet_time_rfc3339        = one(time_static.default[*].rfc3339)
}

data "aws_caller_identity" "default" {
  count = local.enabled ? 1 : 0
}


data "aws_eks_cluster" "cluster" {
  count = local.enabled ? 1 : 0

  name = var.eks_cluster_id
}

data "aws_region" "default" {
  count = local.enabled ? 1 : 0
}

resource "time_static" "default" {
  count = local.enabled ? 1 : 0
}

