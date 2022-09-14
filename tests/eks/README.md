# tests/eks

## Usage

1. Create backend setting file.
    - `cp example.backend.hcl backend.hcl`
1. Set terraform var. One can choose options:
    1. Create tfvars: `cp example.tfvars example.auto.tfvars`
    1. Set `TF_VAR` environment variables (Reccomended for CI/CD)
1. Terraform init: `terraform init -backend-config backend.hcl`
1. Terraform apply: `terraform apply`


<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->