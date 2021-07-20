landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "management"
  level               = "level1"
  key                 = "identity"
  tfstates = {
    management = {
      tfstate = "management.tfstate"
    }
  }
}

resource_groups = {
  network_rg = {
    name   = "network_rg"
    region = "region1"
  }
  domaincontrollers_rg = {
    name   = "domaincontrollers"
    region = "region1"
  }
}