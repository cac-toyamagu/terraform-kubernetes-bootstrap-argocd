terraform {
  required_version = "~>1.3"
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~>0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~>1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2"
    }
  }
}
