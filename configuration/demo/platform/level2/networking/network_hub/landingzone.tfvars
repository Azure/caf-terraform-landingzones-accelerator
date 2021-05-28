landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "network_hub"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "foundations.tfstate"
    }
  }
}

