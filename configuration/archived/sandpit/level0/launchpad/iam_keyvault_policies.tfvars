keyvault_access_policies_azuread_apps = {
  level0 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
  # A maximum of 16 access policies per keyvault
  level1 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }

  # A maximum of 16 access policies per keyvault
  level2 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level3 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level4 = {
    caf_launchpad_level1 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }


  secrets = {
    caf_launchpad_level0 = {
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  level0 = {
    keyvault_level0_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level0_rw"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    msi_level0 = {
      managed_identity_key = "level0"
      secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
  # A maximum of 16 access policies per keyvault
  level1 = {
    keyvault_level1_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level1_rw"
      secret_permissions = ["Get", "List"]
    },
    msi_level0 = {
      managed_identity_key = "level0"
      secret_permissions   = ["Get", "List"]
    }
    msi_level1 = {
      managed_identity_key = "level1"
      secret_permissions   = ["Get"]
    }
  }

  # A maximum of 16 access policies per keyvault
  level2 = {
    keyvault_level2_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level2_rw"
      secret_permissions = ["Get", "List"]
    }
    msi_level0 = {
      managed_identity_key = "level0"
      secret_permissions   = ["Get", "List"]
    }
    msi_level2 = {
      managed_identity_key = "level2"
      secret_permissions   = ["Get"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level3 = {
    keyvault_level3_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level3_rw"
      secret_permissions = ["Get", "List"]
    }
    msi_level0 = {
      managed_identity_key = "level0"
      secret_permissions   = ["Get", "List"]
    }
    msi_level3 = {
      managed_identity_key = "level3"
      secret_permissions   = ["Get"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level4 = {
    keyvault_level4_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level4_rw"
      secret_permissions = ["Get", "List"]
    }
    msi_level0 = {
      managed_identity_key = "level0"
      secret_permissions   = ["Get", "List"]
    }
    msi_level4 = {
      managed_identity_key = "level4"
      secret_permissions   = ["Get"]
    }
  }


  secrets = {
    keyvault_level0_rw = {
      azuread_group_key  = "keyvault_level0_rw"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    keyvault_password_rotation = {
      azuread_group_key  = "keyvault_password_rotation"
      secret_permissions = ["Set", "Get", "List", "Delete", ]
    }
    msi_level0 = {
      managed_identity_key = "level0"
      secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    msi_level1 = {
      managed_identity_key = "level1"
      secret_permissions   = ["Get"]
    }
    msi_level2 = {
      managed_identity_key = "level2"
      secret_permissions   = ["Get"]
    }
    msi_level3 = {
      managed_identity_key = "level3"
      secret_permissions   = ["Set", "Get", "List", "Delete", "Purge"]
    }
    msi_level4 = {
      managed_identity_key = "level4"
      secret_permissions   = ["Get"]
    }
  }
}
