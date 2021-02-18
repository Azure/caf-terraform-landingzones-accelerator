landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "identity"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
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