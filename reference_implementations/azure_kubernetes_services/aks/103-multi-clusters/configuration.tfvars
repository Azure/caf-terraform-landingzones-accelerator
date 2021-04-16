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
    networking_hub = {
      level   = "lower"
      tfstate = "networking_hub.tfstate"
    }
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
  aks_re2 = {
    name   = "aks-re2"
    region = "region2"
  }
  aks_spoke_re1 = {
    name   = "vnet-spoke-aks-re1"
    region = "region1"
  }
  aks_spoke_re2 = {
    name   = "vnet-spoke-aks-re2"
    region = "region2"
  }
}



#
role_mapping = {
  custom_role_mapping = {}

  built_in_role_mapping = {
    azure_container_registries = {
      acr1 = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["cluster_re1", "cluster_re2"]
          }
        }
      }
    }
  }
}