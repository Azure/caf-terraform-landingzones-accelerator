landingzone = {
  backend_type        = "azurerm"
  level               = "level3"
  key                 = "cluster_aks"
  global_settings_key = "shared_services"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "caf_shared_services.tfstate"
    }
    networking_spoke_aks = {
      tfstate = "networking_spoke_aks.tfstate"
    }
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
}
