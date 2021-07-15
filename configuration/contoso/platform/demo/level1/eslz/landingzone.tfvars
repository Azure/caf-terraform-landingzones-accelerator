landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "eslz"
  tfstates = {
    management = {
      level   = "current"
      tfstate = "management.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}
