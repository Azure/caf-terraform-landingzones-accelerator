terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.51.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.2"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = ">= 0.4.0"
    }
  }
  required_version = ">= 0.13"
}
