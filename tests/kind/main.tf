resource "kind_cluster" "this" {
  name           = local.kind.cluster_name
  wait_for_ready = true
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role  = "control-plane"
      image = "kindest/node:v1.23.10"
    }

    node {
      role  = "worker"
      image = "kindest/node:v1.23.10"
    }

    node {
      role  = "worker"
      image = "kindest/node:v1.23.10"
    }

    node {
      role  = "worker"
      image = "kindest/node:v1.23.10"
    }
  }
}

module "argocd" {
  source             = "../../"
  argocd_helm_values = local.helm_values
  git_tokens = [
    {
      url      = "this"
      username = "will"
      password = "fail"
      proxy    = ""
    },
    {
      url      = "https://github.com/cac-toyamagu/terraform-kubernetes-bootstrap-argocd.git"
      username = ""
      password = ""
      proxy    = ""
    }
  ]
  sso_credentials = [
    {
      secretname = "test-sso-secret"
      data = {
        clientId     = var.client_id
        clientSecret = var.client_secret
      }
    }
  ]
  argocd_applications = local.argocd_applications
  argocd_projects     = local.argocd_projects
  depends_on = [
    kubernetes_namespace.argocd_apps
  ]
}

resource "kubernetes_namespace" "argocd_apps" {
  metadata {
    name = "argocd-apps"
  }
}
