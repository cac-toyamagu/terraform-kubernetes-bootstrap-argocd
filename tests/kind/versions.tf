terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.13"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
