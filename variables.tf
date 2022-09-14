variable "argocd_name" {
  description = "ArgoCD name"
  type        = string
  default     = "argocd"
}

variable "argocd_apps_name" {
  description = "ArgoCD apps name"
  type        = string
  default     = "argocd-apps"
}

variable "create_argocd_namespace" {
  description = "Create Argocd Namespace"
  type        = bool
  default     = true
}

variable "argocd_namespace" {
  description = "ArgoCD Namespace"
  type        = string
  default     = "argocd"
}

variable "argocd_helm_repo" {
  description = "ArgoCD helm repository URL"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argocd_helm_chart" {
  description = "ArgoCD helm chart name"
  type        = string
  default     = "argo-cd"
}

variable "argocd_apps_helm_chart" {
  description = "ArgoCD helm chart name"
  type        = string
  default     = "argocd-apps"
}

variable "argocd_helm_version" {
  description = "Argocd helm chart version"
  type        = string
  default     = "5.4.3"
}

variable "argocd_helm_values" {
  description = "Argocd helm values. Will be merged with `./argocd_values.yaml`."
  type        = list(string)
  default     = [""]
}

variable "git_tokens" {
  description = "Git repo token. Proxy is optional."
  type = list(object({
    url      = string
    username = string
    password = string
    proxy    = string
  }))
  default = []
}

variable "sso_credentials" {
  description = "SSO credentials."
  type = list(object({
    secretname = string
    data       = map(any)
  }))
  default = []
}

variable "argocd_applications" {
  description = "ArgoCD applications"
  type        = list(string)
  default     = []
}

variable "argocd_projects" {
  description = "ArgoCD projects"
  type        = list(string)
  default     = []
}

variable "argocd_apps_helm_version" {
  description = "ArgoCD apps helm version"
  type        = string
  default     = "0.0.1"
}
