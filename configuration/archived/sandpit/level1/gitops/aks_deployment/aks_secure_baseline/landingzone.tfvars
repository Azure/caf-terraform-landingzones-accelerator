landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "caf_gitops_aks_secure_baseline"
  tfstates = {
    caf_gitops_aks = {
      level   = "current"
      tfstate = "caf_gitops_aks.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

