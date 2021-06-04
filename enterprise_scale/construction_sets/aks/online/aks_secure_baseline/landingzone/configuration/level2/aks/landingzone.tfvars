landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level2"
  key                 = "aks"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "shared_services.tfstate"
    }
    networking_spoke = {
      level   = "lower"
      tfstate = "networking_spoke.tfstate"
    }
  }
}