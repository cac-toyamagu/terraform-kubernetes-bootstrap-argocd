output "argocd_apps_helm_values" {
  description = "Merged helm values for argocd-apps. JSON encoded."
  value       = helm_release.argocd_apps.metadata[0].values
}

output "argocd_helm_values" {
  description = "Merged helm values for argocd. JSON encoded."
  value       = helm_release.argocd.metadata[0].values
}
