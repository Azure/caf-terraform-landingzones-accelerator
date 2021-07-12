landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "management"
  level               = "level2"
  key                 = "connectivity"
  tfstates = {
    management = {
      level   = "lower"
      tfstate = "management.tfstate"
    }
    identity = {
      level   = "lower"
      tfstate = "identity.tfstate"
    }
  }
}

resource_groups = {
  contoso_global_wan = {
    name   = "contoso-global-wan"
    region = "region1"
  }
  contoso_global_dns = {
    name   = "contoso-global-dns"
    region = "region1"
  }
  contoso_er_circuits = {
    name   = "contoso-er-circuits"
    region = "region1"
  }
}