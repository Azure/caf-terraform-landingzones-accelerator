landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "networking_hub"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
    shared_services = {
      level   = "current"
      tfstate = "shared_services.tfstate"
    }
  }
}
