landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "gitops_connectivity"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

resource_groups = {
  networking = {
    name = "devops-networking"
  }
  bastion_launchpad = {
    name = "devops-bastion"
  }
}

