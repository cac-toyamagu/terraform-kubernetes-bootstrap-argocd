terraform {
  required_version = "~>1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~>1"
    }

    null = {
      source  = "hashicorp/null"
      version = "~>3"
    }
  }
}

