landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "caf_gitops_aks_azure_devops_agents"
  tfstates = {
    launchpad = {
      level = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
    caf_gitops_aks = {
      level   = "current"
      tfstate = "caf_gitops_aks.tfstate"
    }
    azdo_aks_sandpit_caf_configuration = {
      level = "current"
      tfstate = "azdo_aks_sandpit_caf_configuration.tfstate"
    }
  }
}