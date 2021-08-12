landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "gitops_azure_devops_projects"
  tfstates = {
    launchpad = {
      level     = "lower"
      workspace = "tfstate"
      tfstate   = "caf_launchpad.tfstate"
    }
    azure_devops_bootstrap = {
      level     = "current"
      workspace = "tfstate"
      tfstate   = "azure_devops_bootstrap.tfstate"
    }
    identity-gitops = {
      level     = "current"
      workspace = "tfstate"
      tfstate   = "tf-prod-gitops-idn-level1_identity.tfstate"
    }
    identity-gitops-credential-rotation = {
      level     = "current"
      workspace = "credentials"
      tfstate   = "tf-prod-gitops-idn-level1_identity_gitops_credential_rotation.tfstate"
    }
    platform_subscriptions = {
      level     = "current"
      workspace = "tfstate"
      tfstate   = "tf-prod-gitops-caf-level1_platform_subscriptions.tfstate"
    }
  }
}