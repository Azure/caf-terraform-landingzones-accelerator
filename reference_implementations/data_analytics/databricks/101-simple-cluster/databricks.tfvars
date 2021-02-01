landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "databricks_workspace"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "caf_shared_services.tfstate"
    }
    networking_hub = {
      level   = "lower"
      tfstate = "networking_hub.tfstate"
    }
  }
}

resource_groups = {
  databricks_re1 = {
    name   = "databricks-re1"
    region = "region1"
  }
  vnet_re1 = {
    name   = "databricks-networking-re1"
    region = "region1"
  }
}

databricks_workspaces = {
  sales_workspaces = {
    name               = "sales_workspace"
    resource_group_key = "databricks_re1"
    sku                = "standard"
    custom_parameters = {
      no_public_ip       = false
      output_key         = "vnets"
      lz_key             = "networking_spoke_databricks"
      vnet_key           = "vnet_spoke_data_re1"
      public_subnet_key  = "databricks_public"
      private_subnet_key = "databricks_private"
    }
  }
}

keyvaults = {
  secrets_re1 = {
    name               = "data-secrets"
    resource_group_key = "databricks_re1"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  secrets_re1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
  }
}
