landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "synapse_landingzone"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "caf_shared_services.tfstate"
    }
  }
}

resource_groups = {
  dap_synapse_re1 = {
    name = "synapse-rg1"
  }
}

synapse_workspaces = {
  synapse_wrkspc_re1 = {
    name                    = "synapsewpc"
    resource_group_key      = "dap_synapse_re1"
    sql_administrator_login = "dbadmin"
    # sql_administrator_login_password = "<string password>"   # If not set use module autogenerate a strong password and stores it in the keyvault
    keyvault_key = "synapse_secrets"
    data_lake_filesystem = {
      storage_account_key = "synapsestorage_re1"
      container_key       = "synaspe_filesystem"
    }
    workspace_firewall = {
      name     = "AllowAll"
      start_ip = "0.0.0.0"
      end_ip   = "255.255.255.255"
    }
  }
}

storage_accounts = {
  synapsestorage_re1 = {
    name                     = "synapsere1"
    resource_group_key       = "dap_synapse_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
    is_hns_enabled           = true

    data_lake_filesystems = {
      synaspe_filesystem = {
        name = "synapsefilesystem"
        properties = {
          dap = "101-synapse"
        }
      }
    }
  }
}

keyvaults = {
  synapse_secrets = {
    name                = "synapsesecrets"
    resource_group_key  = "dap_synapse_re1"
    sku_name            = "premium"
    soft_delete_enabled = true

    # you can setup up to 5 profiles
    # diagnostic_profiles = {
    #   operations = {
    #     definition_key   = "default_all"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }
  }
}

keyvault_access_policies = {
  synapse_secrets = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    # dap_admins = {
    #   azuread_group_key  = "dap_admins"
    #   secret_permissions = ["Get", "List"]
    # }
  }
}


#
# IAM
#
/* azuread_groups = {
  dap_admins = {
    name        = "dap-admins"
    description = "Provide access to the Data Analytics Platform services and the jumpbox Keyvault secret."
    members = {
      user_principal_names = [
      ]
      group_names = []
      object_ids  = []
      group_keys  = []

      service_principal_keys = [
      ]
    }
    prevent_duplicate_name = false
  }
} */

role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      synapsestorage_re1 = {
        "Storage Blob Data Contributor" = {
          synapse_workspaces = {
            keys = ["synapse_wrkspc_re1"]
          }
        }
      }
    }
  }
}