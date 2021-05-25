landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "hub"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
  }
}

