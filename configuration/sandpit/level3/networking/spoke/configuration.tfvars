landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "networking_spoke_aks"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "caf_shared_services.tfstate"
    }
    networking_hub = {
      level   = "lower"
      tfstate = "networking_hub.tfstate"
    }
  }
}


resource_groups = {
  aks_spoke_re1 = {
    name   = "aks-vnet-spoke-re1"
    region = "region1"
  }
}



