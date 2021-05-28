
keyvaults = {
  sshl0 = {
    name                = "sshl0"
    resource_group_key  = "rg0"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level1_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level1_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level1 = {
        lz_key               = "launchpad"
        managed_identity_key = "level1"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
  sshl1 = {
    name                = "sshl11"
    resource_group_key  = "rg1"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level1_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level1_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level1 = {
        lz_key               = "launchpad"
        managed_identity_key = "level1"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      # Uncomment if run locally, not needed in pipelines deployment.
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
  sshl2 = {
    name                = "sshl2"
    resource_group_key  = "rg2"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level1_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level1_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level1 = {
        lz_key               = "launchpad"
        managed_identity_key = "level1"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      # Uncomment if run locally, not needed in pipelines deployment.
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
  sshl3 = {
    name                = "sshl3"
    resource_group_key  = "rg3"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level1_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level1_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level1 = {
        lz_key               = "launchpad"
        managed_identity_key = "level1"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      # Uncomment if run locally, not needed in pipelines deployment.
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
  sshl4 = {
    name                = "sshl4"
    resource_group_key  = "rg4"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level1_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level1_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level1 = {
        lz_key               = "launchpad"
        managed_identity_key = "level1"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      # Uncomment if run locally, not needed in pipelines deployment.
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}