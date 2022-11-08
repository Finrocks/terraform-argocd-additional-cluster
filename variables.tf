variable "enabled" {
  type        = bool
  default     = null
  description = "Set to false to prevent the module from creating any resources"
}


variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "The Kubernetes namespace where service account will be installed to."
}


variable "insecure" {
  type        = bool
  default     = false
  description = ""
}


variable "eks_cluster_id" {
  type        = string
  default     = null
  description = "EKS cluster ID."
}
