// naming
locals {
  name_common = var.eks_cluster_name
}

// EKS
locals {
  aws = {
    region       = var.aws_region
    default_tags = var.aws_default_tags
  }

  eks = {
    version      = var.eks_version
    cluster_name = var.eks_cluster_name
  }
}

//ArgoCDV
locals {
  helm_values = [templatefile("${path.module}/values.yaml", {})]
  argocd_applications_vars = {
    repo_url        = var.argocd_apps_repo
    target_revision = var.argocd_apps_target_revision
    path            = "tests/eks/argocd"
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

//VPC
locals {
  vpc = {
    cidr            = "10.0.0.0/16"
    secondary_cidr  = ["100.64.0.0/16"]
    azs             = ["${local.aws.region}a", "${local.aws.region}c", "${local.aws.region}d"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    intra_subnets   = ["100.64.1.0/24", "100.64.2.0/24", "100.64.3.0/24"]
    public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  }
}

// EKS用ALB
locals {
  alb_eks_name = format(
    "%s",
    local.name_common
  )

  alb_public_record = format(
    "%s.%s",
    "argocd",
    var.public_root_domain
  )

  alb_target_group_argo = format(
    "%s-argo",
    local.alb_eks_name
  )

  alb = {
    name          = local.alb_eks_name
    public_record = local.alb_public_record
    target_group = {
      argo = local.alb_target_group_argo
    }
  }
}

// SSO
locals {
  // Secrets Manager

  client_id     = try(var.sso_client_id, null)
  client_secret = try(var.sso_client_secret, null)

  aws_sm_sso = {

    name = "${var.eks_cluster_name}-sso"
    values = {
      client_id     = local.client_id
      client_secret = local.client_secret
    }
    is_set = (local.client_id != null && local.client_secret != null ? true : false)
  }
}
