landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "azdo-agent-levels"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
    azdo-contoso_demo = {
      level   = "current"
      tfstate = "azure_devops_contoso_demo.tfstate"
    }
    gitops_connectivity = {
      level   = "current"
      tfstate = "gitops_connectivity.tfstate"
    }
  }
}

resource_groups = {
  rg0 = {
    name = "devops-agents-level0"
  }
  rg1 = {
    name = "devops-agents-level1"
  }
  rg2 = {
    name = "devops-agents-level2"
  }
  rg3 = {
    name = "devops-agents-level3"
  }
  rg4 = {
    name = "devops-agents-level4"
  }
}

azure_devops = {
  level0 = {
    # Rover version to apply to the devops self-hosted agents during the setup.
    rover_version = "aztfmod/rover:0.14.11-2104.2711"
    url           = "https://dev.azure.com/update_with_your_org/"

    pats = {
      agent = {
        secret_name  = "azdo-pat-agent"
        keyvault_key = "secrets"
        lz_key       = "launchpad"
      }
    }

    agent_pool = {
      name              = "caf-sandpit-level0"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
  }
  level1 = {
    url           = "https://dev.azure.com/update_with_your_org/"
    rover_version = "aztfmod/rover:0.14.11-2104.2711"

    pats = {
      agent = {
        secret_name  = "azdo-pat-agent"
        keyvault_key = "secrets"
        lz_key       = "launchpad"
      }
    }

    agent_pool = {
      name              = "caf-sandpit-level1"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
  }
  level2 = {
    url           = "https://dev.azure.com/update_with_your_org/"
    rover_version = "aztfmod/rover:0.14.11-2104.2711"

    pats = {
      agent = {
        secret_name  = "azdo-pat-agent"
        keyvault_key = "secrets"
        lz_key       = "launchpad"
      }
    }

    agent_pool = {
      name              = "caf-sandpit-level2"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
  }
  level3 = {
    url           = "https://dev.azure.com/update_with_your_org/"
    rover_version = "aztfmod/rover:0.14.11-2104.2711"

    pats = {
      agent = {
        secret_name  = "azdo-pat-agent"
        keyvault_key = "secrets"
        lz_key       = "launchpad"
      }
    }

    agent_pool = {
      name              = "caf-sandpit-level3"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
  }
  level4 = {
    url           = "https://dev.azure.com/update_with_your_org/"
    rover_version = "aztfmod/rover:0.14.11-2104.2711"

    pats = {
      agent = {
        secret_name  = "azdo-pat-agent"
        keyvault_key = "secrets"
        lz_key       = "launchpad"
      }
    }

    agent_pool = {
      name              = "caf-sandpit-level4"
      auto_provision    = true
      num_agents        = 4
      agent_name_prefix = "agent"
    }
  }

}

role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      scripts_region1 = {
        "Storage Blob Data Contributor" = {
          azuread_groups = {
            lz_key = "launchpad"
            keys   = ["keyvault_level0_rw"]
          }
          managed_identities = {
            lz_key = "launchpad"
            keys   = ["level0", "level1", "level2", "level3", "level4", ]
          }
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
  }
}
