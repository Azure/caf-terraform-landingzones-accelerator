landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "connectivity"
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
  # contoso_bastion = {
  #   name   = "contoso-bastion"
  #   region = "region1"
  # }
}