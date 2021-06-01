landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "app_service"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "shared_services.tfstate"
    }
    network_hub = {
      level   = "lower"
      tfstate = "network_hub.tfstate"
    }
  }
  resource_defaults = {
    virtual_machines = {
      # set the below to enable az managed boot diagostics for vms
      # this will be override if a user managed storage account is defined for the vm
      # use_azmanaged_storage_for_boot_diagnostics = true
    }
  }
}

resource_groups = {
  vm_region1 = {
    name = "virtual-machine-re1"
  }
}

