landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "azdo-agent-level3"
  level               = "level4"
  key                 = "azdo-agent-level4"
  tfstates = {
    azdo-agent-level3 = {
      level   = "lower"
      tfstate = "azdo-agent-level3.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "azdo-agent-level3.tfstate"
    }
    azdo-contoso_demo = {
      level   = "lower"
      tfstate = "azdo-agent-level3.tfstate"
    }
  }
}

resource_groups = {
  rg1 = {
    name = "devops-agents-level4"
  }
}

azure_devops = {

  # Rover version to apply to the devops self-hosted agents during the setup.
  rover_version = "aztfmod/rover:2012.1109"
  url           = "https://dev.azure.com/azure-terraform/"

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
            keys   = ["level0", "level4"]
          }
          # logged_in = {
          #   keys = ["user"]
          # }
        }
      }
    }
  }
}
