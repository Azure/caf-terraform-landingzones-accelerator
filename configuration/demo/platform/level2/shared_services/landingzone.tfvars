landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "shared_services"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "foundations.tfstate"
    }
  }
}
