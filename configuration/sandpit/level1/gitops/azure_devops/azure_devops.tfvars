
azure_devops = {

  url     = "https://dev.azure.com/update_with_your_org/"
  project = "caf-configuration"

  # PAT Token should be updated manually to the keyvault after running launchpad
  pats = {
    admin = {
      secret_name  = "azdo-pat-admin"
      lz_key       = "launchpad"
      keyvault_key = "secrets"
    }
  }

  organization_agent_pools = {
    level0 = {
      name           = "caf-sandpit-level0"
      auto_provision = false # When set to false the agent pool is not populated automatically into the devops projects (recommended)
    }
    level1 = {
      name           = "caf-sandpit-level1"
      auto_provision = false
    }
    level2 = {
      name           = "caf-sandpit-level2"
      auto_provision = false
    }
    level3 = {
      name           = "caf-sandpit-level3"
      auto_provision = false
    }
    level4 = {
      name           = "caf-sandpit-level4"
      auto_provision = false
    }
  }

  project_agent_pools = {
    level0 = {
      name = "caf-sandpit-level0"
    }
    level1 = {
      name = "caf-sandpit-level1"
    }
    level2 = {
      name = "caf-sandpit-level2"
    }
    level3 = {
      name = "caf-sandpit-level3"
    }
    level4 = {
      name = "caf-sandpit-level4"
    }
  }

   service_endpoints = {
    contoso_demo = {
      endpoint_name       = "Replace with your subscription name"
      subscription_name   = "Replace with your subscription name"
      subscription_id     = "Replace with your subscription ID"
      aad_app_key         = "contoso_demo"
      secret_keyvault_key = "devops"
    }
  }

  variable_groups = {
    global = {
      name         = "release-global" # changing that name requires to change it in the devops agents yaml variables group
      allow_access = true
      variables = {
        HOME_FOLDER_USER    = "vsts_azpcontainer"
        ROVER_IMAGE         = "aztfmod/rover:0.14.11-2104.2711"
        ROVER_RUNNER        = "true"
        TF_CLI_ARGS         = "'-no-color'"
        TF_CLI_ARGS_init    = ""
        TF_CLI_ARGS_plan    = "'-input=false'"
        TF_VAR_ARGS_destroy = "'-auto-approve -refresh=false'"
        ENVIRONMENT         = "sandpit"
        LANDINGZONE_BRANCH  = "2107.1"
      }
    }

    level0 = {
      name         = "release-level0"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level0"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level0"
      }
    }

    level0_kv = {
      name         = "release-level0-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level0"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level1 = {
      name         = "release-level1"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level1"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level1"
      }
    }

    level1_kv = {
      name         = "release-level1-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level1"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level2 = {
      name         = "release-level2"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level2"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level2"
      }
    }

    level2_kv = {
      name         = "release-level2-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level2"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level3 = {
      name         = "release-level3"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level3"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level3"
      }
    }

    level3_kv = {
      name         = "release-level3-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level3"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }

    level4 = {
      name         = "release-level4"
      allow_access = true
      variables = {
        TF_VAR_pipeline_level = "level4"
        ARM_USE_MSI           = "true"
        AGENT_POOL            = "caf-sandpit-level4"
      }
    }

    level4_kv = {
      name         = "release-level4-msi"
      allow_access = true
      keyvault = {
        lz_key              = "launchpad"
        keyvault_key        = "level4"
        serviceendpoint_key = "contoso_demo"
      }
      variables = {
        name = "msi-resource-id"
      }
    }
  }

  pipelines = {
    #
    # End to end
    #
    end_to_end_plan = {
      name          = "end_to_end_plan"
      folder        = "\\configuration\\full"
      yaml          = "configuration/sandpit/pipelines/end_to_end.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        terraformAction = "plan"
      }
    }
    end_to_end_apply = {
      name          = "end_to_end_apply"
      folder        = "\\configuration\\full"
      yaml          = "configuration/sandpit/pipelines/end_to_end.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        terraformAction = "apply"
      }
    }
    end_to_end_destroy = {
      name          = "end_to_end_destroy"
      folder        = "\\configuration\\full"
      yaml          = "configuration/sandpit/pipelines/end_to_end_destroy.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        terraformAction = "destroy -auto-approve"
      }
    }
    #
    # Agent pools
    #

    # # levels
    # devops_agent_levels_plan = {
    #   name          = "devops_agent_levels_plan"
    #   folder        = "\\configuration\\level1"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-levels",
    #     terraformAction = "plan",
    #     tfstateName     = "azdo-agent-levels.tfstate"
    #     configPath      = "/configuration/sandpit/level1/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level1"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level1_apply = {
    #   name          = "devops_agent_level1_apply"
    #   folder        = "\\configuration\\level1"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level1",
    #     terraformAction = "apply",
    #     tfstateName     = "azdo-agent-level1.tfstate"
    #     configPath      = "/configuration/sandpit/level1/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level1"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level1_destroy = {
    #   name          = "devops_agent_level1_destroy"
    #   folder        = "\\configuration\\level1"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level1",
    #     terraformAction = "destroy",
    #     tfstateName     = "azdo-agent-level1.tfstate"
    #     configPath      = "/configuration/sandpit/level1/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level1"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }

    # # level 2
    # devops_agent_level2_plan = {
    #   name          = "devops_agent_level2_plan"
    #   folder        = "\\configuration\\level2"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level2",
    #     terraformAction = "plan",
    #     tfstateName     = "azdo-agent-level2.tfstate"
    #     configPath      = "/configuration/sandpit/level2/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level2"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level2_apply = {
    #   name          = "devops_agent_level2_apply"
    #   folder        = "\\configuration\\level2"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level2",
    #     terraformAction = "apply",
    #     tfstateName     = "azdo-agent-level2.tfstate"
    #     configPath      = "/configuration/sandpit/level2/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level2"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level2_destroy = {
    #   name          = "devops_agent_level2_destroy"
    #   folder        = "\\configuration\\level2"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level2",
    #     terraformAction = "destroy",
    #     tfstateName     = "azdo-agent-level2.tfstate"
    #     configPath      = "/configuration/sandpit/level2/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level2"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }

    # # level 3
    # devops_agent_level3_plan = {
    #   name          = "devops_agent_level3_plan"
    #   folder        = "\\configuration\\level3"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level3",
    #     terraformAction = "plan",
    #     tfstateName     = "azdo-agent-level3.tfstate"
    #     configPath      = "/configuration/sandpit/level3/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level3"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level3_apply = {
    #   name          = "devops_agent_level3_apply"
    #   folder        = "\\configuration\\level3"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level3",
    #     terraformAction = "apply",
    #     tfstateName     = "azdo-agent-level3.tfstate"
    #     configPath      = "/configuration/sandpit/level3/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level3"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level3_destroy = {
    #   name          = "devops_agent_level3_destroy"
    #   folder        = "\\configuration\\level3"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level3",
    #     terraformAction = "destroy",
    #     tfstateName     = "azdo-agent-level3.tfstate"
    #     configPath      = "/configuration/sandpit/level3/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level3"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # # level 4
    # devops_agent_level4_plan = {
    #   name          = "devops_agent_level4_plan"
    #   folder        = "\\configuration\\level4"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level4",
    #     terraformAction = "plan",
    #     tfstateName     = "azdo-agent-level4.tfstate"
    #     configPath      = "/configuration/sandpit/level4/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level4"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level4_apply = {
    #   name          = "devops_agent_level4_apply"
    #   folder        = "\\configuration\\level4"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level4",
    #     terraformAction = "apply",
    #     tfstateName     = "azdo-agent-level4.tfstate"
    #     configPath      = "/configuration/sandpit/level4/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level4"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }
    # devops_agent_level4_destroy = {
    #   name          = "devops_agent_level4_destroy"
    #   folder        = "\\configuration\\level4"
    #   yaml          = "configuration/sandpit/pipelines/rover.yaml"
    #   repo_type     = "TfsGit"
    #   git_repo_name = "caf-configuration"
    #   variables = {
    #     landingZoneName = "azdo-agent-level4",
    #     terraformAction = "destroy",
    #     tfstateName     = "azdo-agent-level4.tfstate"
    #     configPath      = "/configuration/sandpit/level4/azure_devops_agents"
    #     landingZonePath = "/public/landingzones/caf_launchpad/add-ons/azure_devops_agent"
    #     level           = "level4"
    #   }
    #   variable_group_keys = ["global", "level0", "level0_kv"]
    # }

    #
    # LANDING ZONES PIPELINES
    # Level 1 - CAF Foundations
    #
    caf_foundations_plan = {
      name          = "caf_foundations_plan"
      folder        = "\\configuration\\level1"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "caf_foundations",
        terraformAction = "plan",
        tfstateName     = "caf_foundations.tfstate"
        configPath      = "/configuration/sandpit/level1/foundations"
        landingZonePath = "/public/caf_solution"
        level           = "level1"
      }
      variable_group_keys = ["global", "level1", "level1_kv"]
    }
    caf_foundations_apply = {
      name          = "caf_foundations_apply"
      folder        = "\\configuration\\level1"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        pool            = "level0"
        landingZoneName = "caf_foundations",
        terraformAction = "apply",
        tfstateName     = "caf_foundations.tfstate"
        configPath      = "/configuration/sandpit/level1/foundations"
        landingZonePath = "/public/caf_solution"
        level           = "level1"
      }
      variable_group_keys = ["global", "level1", "level1_kv"]
    }
    caf_foundations_destroy = {
      name          = "caf_foundations_destroy"
      folder        = "\\configuration\\level1"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "caf_foundations",
        terraformAction = "destroy",
        tfstateName     = "caf_foundations.tfstate"
        configPath      = "/configuration/sandpit/level1/foundations"
        landingZonePath = "/public/caf_solution"
        level           = "level1"
      }
      variable_group_keys = ["global", "level1", "level1_kv"]
    }

    #
    # Level 2 - Shared Services and Networking
    #

    # Shared Services
    caf_shared_services_plan = {
      name          = "caf_shared_services_plan"
      folder        = "\\configuration\\level2\\shared_services"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "shared_services",
        terraformAction = "plan",
        tfstateName     = "caf_shared_services.tfstate"
        configPath      = "/configuration/sandpit/level2/shared_services"
        landingZonePath = "/public/caf_solution"
        level           = "level2"
      }
      variable_group_keys = ["global", "level2", "level2_kv"]
    }
    caf_shared_services_apply = {
      name          = "caf_shared_services_apply"
      folder        = "\\configuration\\level2\\shared_services"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "shared_services",
        terraformAction = "apply",
        tfstateName     = "caf_shared_services.tfstate"
        configPath      = "/configuration/sandpit/level2/shared_services"
        landingZonePath = "/public/caf_solution"
        level           = "level2"
      }
      variable_group_keys = ["global", "level2", "level2_kv"]
    }
    caf_shared_services_destroy = {
      name          = "caf_shared_services_destroy"
      folder        = "\\configuration\\level2\\shared_services"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "shared_services",
        terraformAction = "destroy",
        tfstateName     = "caf_shared_services.tfstate"
        configPath      = "/configuration/sandpit/level2/shared_services"
        landingZonePath = "/public/caf_solution"
        level           = "level2"
      }
      variable_group_keys = ["global", "level2", "level2_kv"]
    }

    # Networking Hub
    caf_networking_hub_plan = {
      name          = "caf_networking_hub_plan"
      folder        = "\\configuration\\level2\\networking\\hub"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "networking_hub",
        terraformAction = "plan",
        tfstateName     = "networking_hub.tfstate"
        configPath      = "/configuration/sandpit/level2/networking/hub"
        landingZonePath = "/public/caf_solution"
        level           = "level2"
      }
      variable_group_keys = ["global", "level2", "level2_kv"]
    }
    caf_networking_hub_apply = {
      name          = "caf_networking_hub_apply"
      folder        = "\\configuration\\level2\\networking\\hub"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "networking_hub",
        terraformAction = "apply",
        tfstateName     = "networking_hub.tfstate"
        configPath      = "/configuration/sandpit/level2/networking/hub"
        landingZonePath = "/public/caf_solution"
        level           = "level2"
      }
      variable_group_keys = ["global", "level2", "level2_kv"]
    }
    caf_networking_hub_destroy = {
      name          = "caf_networking_hub_destroy"
      folder        = "\\configuration\\level2\\networking\\hub"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "networking_hub",
        terraformAction = "destroy",
        tfstateName     = "networking_hub.tfstate"
        configPath      = "/configuration/sandpit/level2/networking/hub"
        landingZonePath = "/public/caf_solution"
        level           = "level2"
      }
      variable_group_keys = ["global", "level2", "level2_kv"]
    }

    #
    # Level 3 - Application Platforms
    #

    # AKS
    caf_aks_plan = {
      name          = "caf_aks_plan"
      folder        = "\\configuration\\level3\\aks"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "aks",
        terraformAction = "plan",
        tfstateName     = "landing_zone_aks.tfstate"
        configPath      = "/configuration/sandpit/level3/aks"
        landingZonePath = "/public/caf_solution"
        level           = "level3"
      }
      variable_group_keys = ["global", "level3", "level3_kv"]
    }
    caf_aks_apply = {
      name          = "caf_aks_apply"
      folder        = "\\configuration\\level3\\aks"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "aks",
        terraformAction = "apply",
        tfstateName     = "landing_zone_aks.tfstate"
        configPath      = "/configuration/sandpit/level3/aks"
        landingZonePath = "/public/caf_solution"
        level           = "level3"
      }
      variable_group_keys = ["global", "level3", "level3_kv"]
    }
    caf_aks_destroy = {
      name          = "caf_aks_destroy"
      folder        = "\\configuration\\level3\\aks"
      yaml          = "configuration/sandpit/pipelines/rover.yaml"
      repo_type     = "TfsGit"
      git_repo_name = "caf-configuration"
      variables = {
        landingZoneName = "aks",
        terraformAction = "destroy",
        tfstateName     = "landing_zone_aks.tfstate"
        configPath      = "/configuration/sandpit/level3/aks"
        landingZonePath = "/public/caf_solution"
        level           = "level3"
      }
      variable_group_keys = ["global", "level3", "level3_kv"]
    }

  }
}