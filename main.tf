resource "helm_release" "argocd" {
  name = local.argocd.name

  repository = local.argocd.helm_repo
  chart      = local.argocd.helm_chart
  namespace  = local.argocd.namespace
  version    = local.argocd.helm_version
  values     = local.argocd.helm_values

  create_namespace = local.helm_config.create_namespace
  timeout          = local.helm_config.timeout
}

resource "helm_release" "argocd_apps" {
  name = local.argocd_apps.name

  repository = local.argocd_apps.helm_repo
  chart      = local.argocd_apps.helm_chart
  namespace  = local.argocd_apps.namespace
  values     = local.argocd_apps.helm_values
  #version    = local.argocd_apps.helm_version

  create_namespace = local.helm_config.create_namespace
  timeout          = local.helm_config.timeout

  depends_on = [
    helm_release.argocd
  ]
}




resource "kubernetes_secret" "argocd_git_token" {
  for_each = { for k, v in var.git_tokens : k => v }

  metadata {
    name      = "${each.key}-repo-secret-git-token"
    namespace = local.argocd.namespace
    labels    = { "argocd.argoproj.io/secret-type" : "repository" }
  }

  data = {
    #sshPrivateKey = data.aws_secretsmanager_secret_version.ssh_key_version[each.key].secret_string
    username = each.value.username
    type     = "git"
    url      = each.value.url
    password = each.value.password
  }
  depends_on = [
    helm_release.argocd
  ]
}

resource "kubernetes_secret" "argocd_sso_credentials" {
  for_each = { for k, v in var.sso_credentials : k => v }

  metadata {
    name      = each.value.secretname
    namespace = local.argocd.namespace
    labels = {
      "argocd.argoproj.io/secret-type" : "sso-credential"
      "app.kubernetes.io/part-of" : "argocd"
    }
  }

  data = each.value.data

  depends_on = [
    helm_release.argocd
  ]
}
