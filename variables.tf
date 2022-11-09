variable "insecure" {
  type        = bool
  default     = false
  description = ""
}


variable "eks_cluster_id" {
  type        = string
  description = "EKS cluster ID."
}
