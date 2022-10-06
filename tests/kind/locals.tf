locals {
  kind = {
    cluster_name = var.kind_cluster_name
  }
  helm_values_vars = {
    repo_url        = var.argocd_apps_repo
    target_revision = var.argocd_apps_target_revision
    path            = "tests/kind/argocd/kustomize-guestbook/*"
  }
  helm_values = var.read_local_helm_values ? [templatefile("${path.module}/values.yaml", local.helm_values_vars)] : []
  argocd_applications_vars = {
    repo_url        = var.argocd_apps_repo
    target_revision = var.argocd_apps_target_revision
    path            = "tests/kind/argocd/app"
  }
  argocd_applications = [
    templatefile("${path.module}/argocd/apps/applications.yaml.tftpl", local.argocd_applications_vars)
  ]

  argocd_projects_vars = {
  }
  argocd_projects = [
    templatefile("${path.module}/argocd/projects/projects.yaml.tftpl", local.argocd_projects_vars)
  ]
}
