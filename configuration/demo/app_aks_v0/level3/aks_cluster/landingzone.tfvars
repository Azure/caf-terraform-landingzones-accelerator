landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "aks_cluster"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "shared_services.tfstate"
    }
    network_hub = {
      level   = "lower"
      tfstate = "network_hub.tfstate"
    }
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
  aks_spoke_re1 = {
    name   = "aks-vnet-spoke-re1"
    region = "region1"
  }
}
