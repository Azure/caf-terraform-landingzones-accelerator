landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "networking_spoke"
  level               = "level2"
  key                 = "aks"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
    shared_services = {
      level   = "lower"
      tfstate = "caf_shared_services.tfstate"
    }
    networking_spoke = {
      level   = "lower"
      tfstate = "networking_spoke.tfstate"
    }
  }
}