landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "caf_foundations"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

resource_groups = {
  contoso_mgmt = {
    name   = "contoso-mgmt"
    region = "region1"
  }
  contoso_secrets = {
    name   = "contoso-secrets"
    region = "region1"
  }
  contoso_storage = {
    name   = "contoso-storage"
    region = "region1"
  }
}