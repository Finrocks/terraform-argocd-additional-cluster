variable "enabled" {
  type        = bool
  default     = null
  description = "Set to false to prevent the module from creating any resources"
}


variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique"
}


variable "insecure" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}


variable "eks_cluster_id" {
  type        = string
  description = "EKS cluster ID."
}
