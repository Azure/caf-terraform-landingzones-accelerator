landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "aks"
  level               = "level2"
  key                 = "aks_secure_baseline"
  tfstates = {
    aks = {
      level   = "current"
      tfstate = "aks.tfstate"
    }
  }
}