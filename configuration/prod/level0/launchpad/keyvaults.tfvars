
keyvaults = {
  level0 = {
    name               = "l0"
    resource_group_key = "level0"
    sku_name           = "premium"
    tags = {
      tfstate         = "level0"
      environment     = "prod"
      caf_tfstate     = "level0"
      caf_environment = "prod"
    }

    creation_policies = {
      caf_launchpad_maintainer = {
        azuread_group_key  = "caf_launchpad_maintainer"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

  }

  level1 = {
    name               = "l1"
    resource_group_key = "level1"
    sku_name           = "premium"
    tags = {
      tfstate         = "level1"
      environment     = "prod"
      caf_tfstate     = "level1"
      caf_environment = "prod"
    }

    creation_policies = {
      caf_launchpad_maintainer = {
        azuread_group_key  = "caf_launchpad_maintainer"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

  }

  level2 = {
    name               = "l2"
    resource_group_key = "level2"
    sku_name           = "premium"
    tags = {
      tfstate         = "level2"
      environment     = "prod"
      caf_tfstate     = "level2"
      caf_environment = "prod"
    }

    creation_policies = {
      caf_launchpad_maintainer = {
        azuread_group_key  = "caf_launchpad_maintainer"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

  }

  level3 = {
    name               = "l3"
    resource_group_key = "level3"
    sku_name           = "premium"
    tags = {
      tfstate         = "level3"
      environment     = "prod"
      caf_tfstate     = "level3"
      caf_environment = "prod"
    }

    creation_policies = {
      caf_launchpad_maintainer = {
        azuread_group_key  = "caf_launchpad_maintainer"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

  }

}
