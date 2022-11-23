# terraform-bootstrap-argocd

## Purpose

- Bootstrap a Kubernetes cluster with ArgoCD.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.3 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~>2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~>2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.6.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.argocd_apps](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.argocd_git_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.argocd_sso_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_applications"></a> [argocd\_applications](#input\_argocd\_applications) | ArgoCD applications | `list(string)` | `[]` | no |
| <a name="input_argocd_apps_helm_chart"></a> [argocd\_apps\_helm\_chart](#input\_argocd\_apps\_helm\_chart) | ArgoCD helm chart name | `string` | `"argocd-apps"` | no |
| <a name="input_argocd_apps_helm_version"></a> [argocd\_apps\_helm\_version](#input\_argocd\_apps\_helm\_version) | ArgoCD apps helm version | `string` | `"0.0.1"` | no |
| <a name="input_argocd_apps_name"></a> [argocd\_apps\_name](#input\_argocd\_apps\_name) | ArgoCD apps name | `string` | `"argocd-apps"` | no |
| <a name="input_argocd_helm_chart"></a> [argocd\_helm\_chart](#input\_argocd\_helm\_chart) | ArgoCD helm chart name | `string` | `"argo-cd"` | no |
| <a name="input_argocd_helm_repo"></a> [argocd\_helm\_repo](#input\_argocd\_helm\_repo) | ArgoCD helm repository URL | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_argocd_helm_values"></a> [argocd\_helm\_values](#input\_argocd\_helm\_values) | Argocd helm values. Will be merged with `./argocd_values.yaml`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_argocd_helm_version"></a> [argocd\_helm\_version](#input\_argocd\_helm\_version) | Argocd helm chart version | `string` | `"5.4.3"` | no |
| <a name="input_argocd_name"></a> [argocd\_name](#input\_argocd\_name) | ArgoCD name | `string` | `"argocd"` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | ArgoCD Namespace | `string` | `"argocd"` | no |
| <a name="input_argocd_projects"></a> [argocd\_projects](#input\_argocd\_projects) | ArgoCD projects | `list(string)` | `[]` | no |
| <a name="input_create_argocd_namespace"></a> [create\_argocd\_namespace](#input\_create\_argocd\_namespace) | Create Argocd Namespace | `bool` | `true` | no |
| <a name="input_git_tokens"></a> [git\_tokens](#input\_git\_tokens) | Git repo token. Proxy is optional. | <pre>list(object({<br>    url      = string<br>    username = string<br>    password = string<br>    proxy    = string<br>  }))</pre> | `[]` | no |
| <a name="input_sso_credentials"></a> [sso\_credentials](#input\_sso\_credentials) | SSO credentials. | <pre>list(object({<br>    secretname = string<br>    data       = map(any)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argocd_apps_helm_values"></a> [argocd\_apps\_helm\_values](#output\_argocd\_apps\_helm\_values) | Merged helm values for argocd-apps. JSON encoded. |
| <a name="output_argocd_helm_values"></a> [argocd\_helm\_values](#output\_argocd\_helm\_values) | Merged helm values for argocd. JSON encoded. |
<!-- END_TF_DOCS -->