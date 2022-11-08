resource "kubernetes_service_account_v1" "argocd_admin" {
  metadata {
    name      = "argocd-admin"
    namespace = local.namespace
  }
}

resource "kubernetes_cluster_role_v1" "argocd_admin" {
  metadata {
    name = "argocd-admin-role"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role_binding_v1" "argocd_admin" {
  metadata {
    name = "argocd-admin-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.argocd_admin.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.argocd_admin.metadata.0.name
    namespace = kubernetes_service_account_v1.argocd_admin.metadata.0.namespace
  }

}


data "kubernetes_secret_v1" "argocd_admin" {
  metadata {
    name      = kubernetes_service_account_v1.argocd_admin.default_secret_name
    namespace = kubernetes_service_account_v1.argocd_admin.metadata.0.namespace
  }
}

resource "argocd_cluster" "additional" {
  server = local.argocd_endpoint
  name   = local.eks_cluster_name

  config {
    bearer_token = data.kubernetes_secret_v1.argocd_admin.data.token
    tls_client_config {
      ca_data = local.ca_data
      insecure = local.insecure
    }
  }
}







module "argocd_deployer_role" {
  enabled = false
  source  = "cloudposse/iam-role/aws"
  version = "0.17.0"

  role_description      = "IAM Role to be used by ArgoCD to deploy in the SaaS cluster"
  policy_description    = "Allow to assume this role by ArgoCD"
  policy_document_count = 0

  principals = {
    AWS = [
      module.argocd.server_service_account_role_arn,
      module.argocd.application_controller_service_account_role_arn
#      local.argo_workflows_cdp_sa_role_arn
    ]
  }

  assume_role_actions = [
    "sts:AssumeRole",
    "sts:AssumeRoleWithWebIdentity"
  ]

  context    = module.argocd_label.context
  attributes = ["argocd", "deployer"]
}
