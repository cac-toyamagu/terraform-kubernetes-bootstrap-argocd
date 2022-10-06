variable "kind_cluster_name" {
  description = "Kind cluster name"
  type        = string
  default     = "kind-cluster"
}

variable "read_local_helm_values" {
  description = "Determines whether read values.yaml or not."
  type        = bool
  default     = true
}

variable "sso-secret-name" {
  description = "SSO secret name"
  type        = string
  default     = "sso-client-secret"
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
  default     = "https://github.com/toyamagu-2021/terraform-kubernetes-bootstrap-argocd.git"
}

variable "argocd_apps_target_revision" {
  description = "Argocd apps target revision."
  type        = string
  default     = "main"
}
