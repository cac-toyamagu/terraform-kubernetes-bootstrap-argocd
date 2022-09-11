output "argocd_apps_helm_values" {
  value = local.argocd_apps.helm_values
}

output "argocd_helm_values" {
  value = local.argocd.helm_values
}
