terraform {
  required_providers {
    kubectl = {
      #https://registry.terraform.io/providers/gavinbunney/kubectl/latest
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "kubectl" {
  # Configuration options
}