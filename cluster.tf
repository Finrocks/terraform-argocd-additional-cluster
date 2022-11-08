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
