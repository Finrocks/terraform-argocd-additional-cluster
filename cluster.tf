resource "kubernetes_service_account_v1" "argocd_admin" {
  count = local.enabled ? 1 : 0
  
  metadata {
    name      = "argocd-admin"
    namespace = local.namespace
  }
}

resource "kubernetes_cluster_role_v1" "argocd_admin" {
  count = local.enabled ? 1 : 0
  
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

 depends_on = [kubernetes_service_account_v1.argocd_admin]
}

resource "kubernetes_cluster_role_binding_v1" "argocd_admin" {
  count = local.enabled ? 1 : 0
  
  metadata {
    name = "argocd-admin-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = one(kubernetes_cluster_role_v1.argocd_admin[*].metadata.0.name)
  }

  subject {
    kind      = "ServiceAccount"
    name      = one(kubernetes_service_account_v1.argocd_admin[*].metadata.0.name)
    namespace = one(kubernetes_service_account_v1.argocd_admin[*].metadata.0.namespace)
  }
  
 depends_on = [kubernetes_cluster_role_v1.argocd_admin]
}


data "kubernetes_secret_v1" "argocd_admin" {
  count = local.enabled ? 1 : 0
  
  metadata {
    name      = one(kubernetes_service_account_v1.argocd_admin[*].default_secret_name)
    namespace = one(kubernetes_service_account_v1.argocd_admin[*].metadata.0.namespace)
  }
  
 depends_on = [kubernetes_cluster_role_binding_v1.argocd_admin] 
}

resource "argocd_cluster" "additional" {
  count = local.enabled ? 1 : 0
  
  server = local.argocd_endpoint
  name   = local.eks_cluster_id

  config {
    bearer_token = one(data.kubernetes_secret_v1.argocd_admin[*].data.token)
    tls_client_config {
      ca_data = local.ca_data
      insecure = local.insecure
    }
  }
  
  depends_on = [data.kubernetes_secret_v1.argocd_admin] 
}
