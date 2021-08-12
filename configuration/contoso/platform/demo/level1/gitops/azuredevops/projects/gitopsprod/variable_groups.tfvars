variable_groups = {
  global = {
    project_key  = "gitopsprod"
    name         = "release-global" # changing that name requires to change it in the devops agents yaml variables group
    allow_access = true
    variables = {
      HOME_FOLDER_USER    = "vsts_azpcontainer"
      ROVER_IMAGE         = "aztfmod/rover:1.0.1-2106.3012"
      TF_CLI_ARGS         = "'-no-color'"
      TF_CLI_ARGS_init    = ""
      TF_CLI_ARGS_plan    = "'-input=false'"
      TF_CLI_ARGS_apply   = "'-input=false -auto-approve'"
      TF_CLI_ARGS_destroy = "'-auto-approve -refresh=false'"
      ENVIRONMENT         = "prod-africa"
      # LANDINGZONE_BRANCH  = "2107.1"
      LANDINGZONE_BRANCH = "hashi-backend-role"
      CONFIG_BRANCH      = "mtms"
      ROVER_RUNNER       = "true"
      ARM_USE_AZUREAD    = "true"
    }
  }


  azdo_pat_admin = {
    project_key  = "gitopsprod"
    name         = "azdo-pat-admin"
    allow_access = true
    keyvault = {
      lz_key              = "azure_devops_bootstrap"
      keyvault_key        = "azuredevops"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "azdo-pat-admin"
    }
  }

  level0 = {
    project_key  = "gitopsprod"
    name         = "release-level0"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level0"
      ARM_USE_MSI    = "false"
      AGENT_POOL     = "gitops-level0"
    }
  }

  level1 = {
    project_key  = "gitopsprod"
    name         = "release-level1"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level1"
      ARM_USE_MSI    = "false"
      AGENT_POOL     = "gitops-level1"
    }
  }

  level2 = {
    project_key  = "gitopsprod"
    name         = "release-level2"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level2"
      ARM_USE_MSI    = "false"
      AGENT_POOL     = "gitops-level2"
    }
  }

  level3 = {
    project_key  = "gitopsprod"
    name         = "release-level3"
    allow_access = true
    variables = {
      PIPELINE_LEVEL = "level3"
      ARM_USE_MSI    = "false"
      AGENT_POOL     = "gitops-level3"
    }
  }

  # TODO - move to this settings

  # launchpad = {
  #   project_key    = "gitopsprod"
  #   name           = "launchpad"
  #   allow_access   = true
  #   remote_objects = true
  #   variables = {
  #     TARGET_SUBSCRIPTION_ID = {
  #       name          = "TARGET_SUBSCRIPTION_ID"
  #       output_key    = "subscriptions"
  #       lz_key        = "bootstrap"
  #       resource_key  = "caf_launchpad"
  #       attribute_key = "subscription_id"
  #     }
  #   }
  # }

  # tfstate = {
  #   project_key    = "gitopsprod"
  #   name           = "tfstate"
  #   allow_access   = true
  #   remote_objects = true
  #   variables = {
  #     TFSTATE_SUBSCRIPTION_ID = {
  #       name          = "TFSTATE_SUBSCRIPTION_ID"
  #       output_key    = "subscriptions"
  #       lz_key        = "bootstrap"
  #       resource_key  = "caf_launchpad"
  #       attribute_key = "subscription_id"
  #     }
  #   }
  # }

  tfstate = {
    project_key  = "gitopsprod"
    name         = "tfstate"
    allow_access = true
    variables = {
      TFSTATE_SUBSCRIPTION_ID = "11646ce1-8081-4d30-881c-ace8cdba2390"
    }
  }

  launchpad = {
    project_key  = "gitopsprod"
    name         = "launchpad"
    allow_access = true
    variables = {
      TARGET_SUBSCRIPTION_ID = "11646ce1-8081-4d30-881c-ace8cdba2390"
    }
  }

  vhub-tenant-id = {
    project_key  = "gitopsprod"
    name         = "vhub-tenant-id"
    allow_access = true
    variables = {
      TARGET_TENANT_ID = "85fd5e88-3dba-4219-bb44-77865e3ff7c4"
    }
  }

  vhub-tfstate-subscription-id = {
    project_key  = "gitopsprod"
    name         = "vhub-tfstate-subscription-id"
    allow_access = true
    variables = {
      VHUB_TFSTATE_SUBSCRIPTION_ID = "655bfcb5-1e28-431b-9d71-500f15f6ded0"
    }
  }


  # Devops subscription with the AKS cluster
  devops = {
    project_key    = "gitopsprod"
    name           = "devops"
    allow_access   = true
    remote_objects = true
    variables = {
      TARGET_SUBSCRIPTION_ID = {
        name          = "TARGET_SUBSCRIPTION_ID"
        output_key    = "subscriptions"
        lz_key        = "platform_subscriptions"
        resource_key  = "devops"
        attribute_key = "subscription_id"
      }
    }
  }

  #LBU
  management = {
    project_key  = "gitopsprod"
    name         = "management"
    allow_access = true
    variables = {
      TARGET_SUBSCRIPTION_ID = "f47142c3-d64a-4b08-8a63-c0815e945e41"
    }
  }

  #LBU
  identity = {
    project_key  = "gitopsprod"
    name         = "identity"
    allow_access = true
    variables = {
      TARGET_SUBSCRIPTION_ID = "6977bab5-aced-4870-bc51-7068ec3a9d71"
    }
  }

  bitbucket_kv = {
    project_key  = "gitopsprod"
    name         = "bitbucket"
    allow_access = true
    keyvault = {
      lz_key              = "azure_devops_bootstrap"
      keyvault_key        = "bitbucket"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "bitbucket-pat"
    }
  }

  hashicorp_vault_url = {
    project_key  = "gitopsprod"
    name         = "hashicorp-vault-url"
    allow_access = true
    keyvault = {
      lz_key              = "azure_devops_bootstrap"
      keyvault_key        = "hashicorp_vault"
      serviceendpoint_key = "gitops-prod-devops"
    }
    variables = {
      name = "hashicorp-vault-url"
    }
  }

  hashicorp_role_id = {
    project_key  = "gitopsprod"
    name         = "hashicorp-role-id"
    allow_access = true
    keyvault = {
      lz_key              = "azure_devops_bootstrap"
      keyvault_key        = "hashicorp_vault"
      serviceendpoint_key = "gitops-prod-devops"
    }
    variables = {
      name = "hashicorp-role-id"
    }
  }

  hashicorp_secret_id = {
    project_key  = "gitopsprod"
    name         = "hashicorp-secret-id"
    allow_access = true
    keyvault = {
      lz_key              = "azure_devops_bootstrap"
      keyvault_key        = "hashicorp_vault"
      serviceendpoint_key = "gitops-prod-devops"
    }
    variables = {
      name = "hashicorp-secret-id"
    }
  }

  # account_owner credential
  account_owner_username = {
    project_key  = "gitopsprod"
    name         = "account-owner-username"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "account_owner"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "account-owner-username"
    }
  }

  account_owner_password = {
    project_key  = "gitopsprod"
    name         = "account-owner-password"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "account_owner"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "account-owner-password"
    }
  }

  tenant_id = {
    project_key  = "gitopsprod"
    name         = "tenant-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "account_owner"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "tenant-id"
    }
  }

  # level0 Service Principals secrets
  level0_client_id = {
    project_key  = "gitopsprod"
    name         = "level0-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "level0-id"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  level0_client_secret = {
    project_key  = "gitopsprod"
    name         = "level0-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "level0-id"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # identity Service Principals secrets
  identity_client_id = {
    project_key  = "gitopsprod"
    name         = "identity-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "identity"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  identity_client_secret = {
    project_key  = "gitopsprod"
    name         = "identity-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "identity"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # management Service Principals secrets
  management_client_id = {
    project_key  = "gitopsprod"
    name         = "management-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "management"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  management_client_secret = {
    project_key  = "gitopsprod"
    name         = "management-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "management"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # eslz Service Principals secrets
  eslz_client_id = {
    project_key  = "gitopsprod"
    name         = "eslz-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "eslz"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  eslz_client_secret = {
    project_key  = "gitopsprod"
    name         = "eslz-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "eslz"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # connectivity Service Principals secrets
  connectivity_client_id = {
    project_key  = "gitopsprod"
    name         = "connectivity-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "connectivity"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  connectivity_client_secret = {
    project_key  = "gitopsprod"
    name         = "connectivity-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "connectivity"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # subscription_creation_platform Service Principals secrets
  subscription_creation_platform_client_id = {
    project_key  = "gitopsprod"
    name         = "subscription-creation-platform-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "subscription_creation_platform"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  subscription_creation_platform_client_secret = {
    project_key  = "gitopsprod"
    name         = "subscription-creation-platform-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "subscription_creation_platform"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # subscription_creation_landingzones Service Principals secrets
  subscription_creation_landingzones_client_id = {
    project_key  = "gitopsprod"
    name         = "subscription-creation-landingzones-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "subscription_creation_landingzones"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  subscription_creation_landingzones_client_secret = {
    project_key  = "gitopsprod"
    name         = "subscription-creation-landingzones-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "subscription_creation_landingzones"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # vhub_peering Service Principals secrets
  vhub-peering-client-id = {
    project_key  = "gitopsprod"
    name         = "vhub-peering-sp-client-id"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "vhub_peering"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-id"
    }
  }

  vhub-peering-client-secret = {
    project_key  = "gitopsprod"
    name         = "vhub-peering-sp-client-secret"
    allow_access = true
    keyvault = {
      lz_key              = "identity-gitops-credential-rotation"
      keyvault_key        = "vhub_peering"
      serviceendpoint_key = "gitopsprod"
    }
    variables = {
      name = "sp-client-secret"
    }
  }

  # identity_rotation_lbu = {
  #   project_key  = "gitopsprod"
  #   name         = "identity-rotation-lbu"
  #   allow_access = true
  #   variables = {
  #     LBU_MATRIX = "{\"gitopsprod\": {\"CONFIG_PATH\": \"gitopsprod/level1/identity/gitopsprod/credentials\", \"TFSTATE_NAME\": \"tf-prod-gitops-idn-level1_identity_gitops_credential_rotation.tfstate\"}, \"afrtss\": {\"CONFIG_PATH\": \"gitopsprod/level1/identity/AFRTSS/credentials\", \"TFSTATE_NAME\": \"tf-prod-gitops-idn-level1_identity_afrtss_credential_rotation.tfstate\"}}"
  #   }
  #   variables_objects = {
  #     PASSWORD_ROTATION = {
  #       gitops = {
  #         CONFIG_PATH  = "gitopsprod/level1/identity/gitopsprod/credentials"
  #         TFSTATE_NAME = "tf-prod-gitops-idn-level1_identity_gitops_credential_rotation.tfstate"
  #       }
  #       afrtss = {
  #         CONFIG_PATH  = "gitopsprod/level1/identity/AFRTSS/credentials"
  #         TFSTATE_NAME = "tf-prod-gitops-idn-level1_identity_afrtss_credential_rotation.tfstate"
  #       }
  #       glrtss = {
  #         CONFIG_PATH  = "gitopsprod/level1/identity/glrtss/credentials"
  #         TFSTATE_NAME = "tf-prod-gitops-idn-level1_identity_glrtss_credential_rotation.tfstate"
  #       }
  #       uglife = {
  #         CONFIG_PATH  = "gitopsprod/level1/identity/UGLIFE/credentials"
  #         TFSTATE_NAME = "tf-prod-gitops-idn-level1_identity_uglife_credential_rotation.tfstate"
  #       }
  #     }
  #   }
  # }

  # identity_hashicorp_secrets_lbu = {
  #   project_key  = "gitopsprod"
  #   name         = "identity-hashicorp-secrets-lbu"
  #   allow_access = true
  #   variables_objects = {
  #     HASHICORP_VAULT_ROTATION = {
  #       afrtss = {
  #         CONFIG_PATH      = "gitopsprod/level1/identity/AFRTSS/hashicorp"
  #         TFSTATE_NAME     = "tf-prod-gitops-caf-level1_identity_afrtss_hashicorp_secrets.tfstate"
  #         LANDINGZONE_PATH = "caf_solution/add-ons/hashicorp_vault_secrets"
  #       }
  #       uglife = {
  #         CONFIG_PATH      = "gitopsprod/level1/identity/UGLIFE/hashicorp"
  #         TFSTATE_NAME     = "tf-prod-gitops-caf-level1_identity_uglife_hashicorp_secrets.tfstate"
  #         LANDINGZONE_PATH = "caf_solution/add-ons/hashicorp_vault_secrets"
  #       }
  #     }
  #   }
  # }


}
