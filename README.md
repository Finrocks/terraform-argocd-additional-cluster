# terraform-argocd-additional-cluster

```hcl
   module "argocd_additional_cluster" {
     enabled = true
     source              = "git::git@github.com:Finrocks/terraform-argocd-additional-cluster.git?ref=master"
     
     eks_cluster_id      = module.eks.eks_cluster_id
     
     depends_on = [module.argocd]
   }   
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_argocd"></a> [argocd](#requirement\_argocd) | >= 4.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.38.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_argocd"></a> [argocd](#provider\_argocd) | >= 4.1.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.38.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [argocd_cluster.additional](https://registry.terraform.io/providers/oboukili/argocd/latest/docs/resources/cluster) | resource |
| [kubernetes_cluster_role_binding_v1.argocd_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding_v1) | resource |
| [kubernetes_cluster_role_v1.argocd_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_v1) | resource |
| [kubernetes_service_account_v1.argocd_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account_v1) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [kubernetes_secret_v1.argocd_admin](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret_v1) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cluster_id"></a> [eks\_cluster\_id](#input\_eks\_cluster\_id) | EKS cluster ID. | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_insecure"></a> [insecure](#input\_insecure) | n/a | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace where service account will be installed to. | `string` | `"kube-system"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_data"></a> [ca\_data](#output\_ca\_data) | n/a |
<!-- END_TF_DOCS -->
