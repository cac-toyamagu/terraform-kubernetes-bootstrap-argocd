# tests/kind

## Purpose

- Test this module in a local kind cluster.
- One can use the ArgoCD dex.
- One can register a private repository.

## Access to argocd via browser

- `kubectl port-forward service/argocd-server -n argocd 8000:80`

## Gitlab OAuth Application

- Create a github sso secrets.
  - ![create oauth application](./figs/create-github-oauth-application.png)
- Write `clientId` and `clientSecret` into `terraform.tfvars`. **DONT' push it to GitHub**.

  ```bash
  cat > terraform.tfvars <<EOF
  client_id="<clientId>"
  client_secret="<clientSecret>"
  EOF
  ```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | 0.0.13 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.0.13 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.13.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [kind_cluster.this](https://registry.terraform.io/providers/tehcyx/kind/0.0.13/docs/resources/cluster) | resource |
| [kubernetes_namespace.argocd_apps](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_apps_repo"></a> [argocd\_apps\_repo](#input\_argocd\_apps\_repo) | Argocd apps repository. | `string` | `"https://github.com/cac-toyamagu/terraform-kubernetes-bootstrap-argocd.git"` | no |
| <a name="input_argocd_apps_target_revision"></a> [argocd\_apps\_target\_revision](#input\_argocd\_apps\_target\_revision) | Argocd apps target revision. | `string` | `"main"` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | SSO client Id | `string` | `"ClientId"` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | SSO client secret | `string` | `"ClientSecert"` | no |
| <a name="input_kind_cluster_name"></a> [kind\_cluster\_name](#input\_kind\_cluster\_name) | Kind cluster name | `string` | `"kind-cluster"` | no |
| <a name="input_read_local_helm_values"></a> [read\_local\_helm\_values](#input\_read\_local\_helm\_values) | Determines whether read values.yaml or not. | `bool` | `true` | no |
| <a name="input_sso-secret-name"></a> [sso-secret-name](#input\_sso-secret-name) | SSO secret name | `string` | `"sso-client-secret"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argocd_apps_helm_values"></a> [argocd\_apps\_helm\_values](#output\_argocd\_apps\_helm\_values) | n/a |
<!-- END_TF_DOCS -->