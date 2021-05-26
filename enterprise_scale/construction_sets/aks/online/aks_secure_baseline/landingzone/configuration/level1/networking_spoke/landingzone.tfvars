landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "networking_spoke"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
    networking_hub = {
      level   = "current"
      tfstate = "networking_hub.tfstate"
    }
  }
}