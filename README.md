# terraform-bootstrap-argocd

## Purpose

- Bootstrap a Kubernetes cluster with ArgoCD.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

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
| [kubernetes_secret.argocd_git_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.argocd_sso_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_helm_chart"></a> [argocd\_helm\_chart](#input\_argocd\_helm\_chart) | ArgoCD helm chart name | `string` | `"argo-cd"` | no |
| <a name="input_argocd_helm_repo"></a> [argocd\_helm\_repo](#input\_argocd\_helm\_repo) | ArgoCD helm repository URL | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_argocd_helm_values"></a> [argocd\_helm\_values](#input\_argocd\_helm\_values) | Argocd helm values. Will be merged with `./argocd_values.yaml` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_argocd_helm_version"></a> [argocd\_helm\_version](#input\_argocd\_helm\_version) | Argocd helm chart version | `string` | `"4.8.0"` | no |
| <a name="input_argocd_name"></a> [argocd\_name](#input\_argocd\_name) | ArgoCD name | `string` | `"argocd"` | no |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | ArgoCD Namespace | `string` | `"argocd"` | no |
| <a name="input_create_argocd_namespace"></a> [create\_argocd\_namespace](#input\_create\_argocd\_namespace) | Create Argocd Namespace | `bool` | `true` | no |
| <a name="input_git_tokens"></a> [git\_tokens](#input\_git\_tokens) | Git repo token. Proxy is optional. | <pre>list(object({<br>    url      = string<br>    username = string<br>    password = string<br>    proxy    = string<br>  }))</pre> | `[]` | no |
| <a name="input_sso_credentials"></a> [sso\_credentials](#input\_sso\_credentials) | SSO credentials. | <pre>list(object({<br>    secretname = string<br>    data       = map(any)<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->