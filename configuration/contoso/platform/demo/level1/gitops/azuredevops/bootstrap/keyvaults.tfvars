
keyvaults = {
  azuredevops = {
    name               = "azdo"
    resource_group_key = "azuredevops"
    sku_name           = "standard"

    creation_policies = {
      caf_maintainers = {
        lz_key = "launchpad"
        azuread_group_key          = "caf_launchpad_maintainer"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      grp-level0 = {
        lz_key = "launchpad"
        azuread_group_key  = "grp-azure-devops"
        secret_permissions = ["Get"]
      }
    }
  }
}


keyvault_access_policies = {
  azuredevops = {
    sp_level0 = {
      # Allow level1 devops agent to be managed from agent pool level0
      lz_key                        = "launchpad"
      azuread_service_principal_key = "level0"
      secret_permissions            = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    management = {
      lz_key                        = "launchpad"
      azuread_service_principal_key = "management"
      secret_permissions            = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    identity = {
      lz_key                        = "launchpad"
      azuread_service_principal_key = "identity"
      secret_permissions            = ["Get"]
    }
    eslz = {
      lz_key                        = "launchpad"
      azuread_service_principal_key = "eslz"
      secret_permissions            = ["Get"]
    }
    subscription_creation_platform = {
      lz_key                        = "launchpad"
      azuread_service_principal_key = "subscription_creation_platform"
      secret_permissions            = ["Get"]
    }
    azure_devops = {
      lz_key             = "launchpad"
      azuread_group_key  = "grp-azure-devops"
      secret_permissions =  ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}