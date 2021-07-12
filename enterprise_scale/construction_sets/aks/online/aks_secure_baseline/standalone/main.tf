terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.45"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.11.1"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.14"
    }
  }
  required_version = ">= 0.13"


  # comment it out for the local backend experience
  # backend "azurerm" {}
}


provider "azurerm" {
  partner_id = "451dc593-a3a3-4d41-91e7-3aadf93e1a78"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

