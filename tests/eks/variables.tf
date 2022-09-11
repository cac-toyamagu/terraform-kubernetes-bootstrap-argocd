variable "eks_version" {
  description = "EKS version"
  type        = string
  default     = "1.23"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-cluster-with-argo"
}

variable "aws_default_tags" {
  description = "AWS default tags"
  type        = map(string)
  default = {
    Creator = "toyamagu"
  }
}

variable "client_secret" {
  description = "SSO client secret"
  type        = string
  default     = "ClientSecert"
}

variable "client_id" {
  description = "SSO client Id"
  type        = string
  default     = "ClientId"
}

variable "argocd_apps_repo" {
  description = "Argocd apps repository."
  type        = string
  default     = "https://github.com/cac-toyamagu/terraform-kubernetes-bootstrap-argocd.git"
}

variable "argocd_apps_target_revision" {
  description = "Argocd apps target revision."
  type        = string
  default     = "main"
}

variable "source_cidrs" {
  description = "CIDRs for public access"
  type        = list(string)
  default     = ["0.0.0.0/0"]

}

variable "public_root_domain" {
  description = "Public root domain"
  type        = string
  default     = "example.com"
}
