module "vpc" {
  source                = "terraform-aws-modules/vpc/aws"
  version               = "3.14.4"
  name                  = local.eks.cluster_name
  cidr                  = local.vpc.cidr
  secondary_cidr_blocks = local.vpc.secondary_cidr
  azs                   = local.vpc.azs
  private_subnets       = local.vpc.private_subnets
  intra_subnets         = local.vpc.intra_subnets
  public_subnets        = local.vpc.public_subnets
  enable_nat_gateway    = true
  single_nat_gateway    = true
  enable_dns_hostnames  = true
}

# STEP 2: Create EKS cluster 
module "eks" {
  source                    = "terraform-aws-modules/eks/aws"
  version                   = "18.29.0"
  cluster_name              = local.eks.cluster_name
  cluster_version           = var.eks_version
  subnet_ids                = module.vpc.private_subnets
  vpc_id                    = module.vpc.vpc_id
  cluster_enabled_log_types = ["audit", "api", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.large"]
    capacity_type  = "SPOT"

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    one = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      update_config = {
        max_unavailable_percentage = 50 # or set `max_unavailable`
      }
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description = "Node all egress"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress_cluster_ephemeral_ports_tcp = {
      description                   = "From cluster 1025-65535"
      protocol                      = "tcp"
      from_port                     = 1025
      to_port                       = 65535
      source_cluster_security_group = true
      type                          = "ingress"
    }
  }
}

module "argocd" {
  source             = "../../"
  argocd_helm_values = local.helm_values
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
    kubernetes_namespace.argocd_apps,
    module.eks
  ]
}

resource "kubernetes_namespace" "argocd_apps" {
  metadata {
    name = "argocd-apps"
  }

  depends_on = [
    module.eks
  ]
}


resource "kubernetes_namespace" "infra" {
  metadata {
    name = "infra"
  }

  depends_on = [
    module.eks
  ]
}
