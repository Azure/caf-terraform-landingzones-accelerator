
landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "aml_landingzone"
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
  dap_azure_ml_re1 = {
    name = "machine-learning-rg1"
  }
  vnet_spoke_re1 = {
    name   = "vnet-spoke-dap"
    region = "region1"
  }
}

machine_learning_workspaces = {
  ml_workspace_re1 = {
    name                     = "amlwrkspc"
    resource_group_key       = "dap_azure_ml_re1"
    keyvault_key             = "aml_secrets"
    storage_account_key      = "amlstorage_re1"
    application_insights_key = "ml_app_insight"
    sku_name                 = "Basic" # Enterprise will retire in 2021 & Basic will have all features included

    compute_instances = {
      compute_instance_re1 = {
        computeInstanceName   = "inst25"
        vmSize                = "Standard_DS3_v2" #[For allowed value - refer Readme.md]
        adminUserName         = "azureuser"
        sshAccess             = "Enabled"
        adminUserSshPublicKey = "ssh-rsa AAAAB3NzaC1yc2EAABADAQABAAACAQC1"
        vnet_key              = "spoke_dap_re1"
        subnet_key            = "AmlSubnet"
      }
    }
  }
}

azurerm_application_insights = {
  ml_app_insight = {
    name               = "ml-app-insight"
    resource_group_key = "dap_azure_ml_re1"
    application_type   = "web"
  }
}

storage_accounts = {
  amlstorage_re1 = {
    name                     = "amlwrkspcstg"
    resource_group_key       = "dap_azure_ml_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
}


keyvaults = {
  aml_secrets = {
    name               = "amlsecrets_re1"
    resource_group_key = "dap_azure_ml_re1"
    //convention          = "cafrandom"
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
