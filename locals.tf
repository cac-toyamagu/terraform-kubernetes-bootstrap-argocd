locals {
  default_helm_values = [templatefile("${path.module}/argocd_values.yaml", {})]
  argocd = {
    name         = var.argocd_name
    namespace    = var.argocd_namespace
    helm_repo    = var.argocd_helm_repo
    helm_chart   = var.argocd_helm_chart
    helm_version = var.argocd_helm_version
    helm_values  = concat(local.default_helm_values, var.argocd_helm_values)
  }
  helm_config = {
    timeout          = 1200
    create_namespace = var.create_argocd_namespace
  }

  argocd_apps = {
    name         = var.argocd_apps_name
    namespace    = var.argocd_namespace
    helm_repo    = var.argocd_helm_repo
    helm_chart   = var.argocd_apps_helm_chart
    helm_version = var.argocd_apps_helm_version
    helm_values  = concat(var.argocd_projects, var.argocd_applications)
  }
}
