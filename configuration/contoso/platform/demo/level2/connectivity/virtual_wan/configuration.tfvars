landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "management"
  level               = "level2"
  key                 = "connectivity_virtual_wan"
  tfstates = {
    management = {
      level   = "lower"
      tfstate = "management.tfstate"
    }
  }
}