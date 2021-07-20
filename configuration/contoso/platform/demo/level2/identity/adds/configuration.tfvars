landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "management"
  level               = "level2"
  key                 = "identity_adds"
  tfstates = {
    management = {
      level   = "lower"
      tfstate = "management.tfstate"
    }
    connectivity_virtual_hub1 = {
      level   = "current"
      tfstate = "connectivity_virtual_hub1.tfstate"
    }
    connectivity_virtual_hub2 = {
      level   = "current"
      tfstate = "connectivity_virtual_hub2.tfstate"
    }
  }
}
