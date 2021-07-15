# Availability set for domain controllers
availability_sets = {
  avset1 = {
    name               = "avset-dc"
    region             = "region1"
    resource_group_key = "domaincontrollers_rg"
    # Depends on the region, update and fault domain count availability varies.
    platform_update_domain_count = 2
    platform_fault_domain_count  = 2
    # By default availability set is configured as managed. Below can be used to change it to unmanged.
    # managed                      = false
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  dc01 = {
    resource_group_key                   = "domaincontrollers_rg"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "windows"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "dc01"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key             = "identity_vnet"
        subnet_key           = "ActiveDirectory"
        name                 = "dc01"
        enable_ip_forwarding = false

        diagnostic_profiles = {
          operations = {
            definition_key   = "network_interface_card"
            destination_type = "storage"
            destination_key  = "all_regions"
          }
        }
      }
    }

    virtual_machine_settings = {
      windows = {
        name                 = "dc01"
        size                 = "Standard_F2"
        admin_username       = "adminuser"
        availability_set_key = "avset1"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "dc01-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

      }
    }

    virtual_machine_extensions = {
      microsoft_enterprise_cloud_monitoring = {
        diagnostic_log_analytics_key = "central_logs_region1"
      }

      microsoft_azure_diagnostics = {
        # Requires at least one diagnostics storage account
        diagnostics_storage_account_keys = ["bootdiag_region1"]

        # Relative path to the configuration folder or full path
        xml_diagnostics_file = "{{ config.destination_install_path }}{{ config.destination_relative_base_path }}/{{ level }}/{{ base_folder }}/diagnostics/wadcfg.xml"
      }
    }
  }
  dc02 = {
    resource_group_key                   = "domaincontrollers_rg"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "windows"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "dc01"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key             = "identity_vnet"
        subnet_key           = "ActiveDirectory"
        name                 = "dc02"
        enable_ip_forwarding = false
        #internal_dns_name_label = "nic0"

        diagnostic_profiles = {
          operations = {
            definition_key   = "network_interface_card"
            destination_type = "storage"
            destination_key  = "all_regions"
          }
        }
      }
    }

    virtual_machine_settings = {
      windows = {
        name                 = "dc02"
        size                 = "Standard_F2"
        admin_username       = "adminuser"
        availability_set_key = "avset1"
        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "dc02-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

      }
    }

    virtual_machine_extensions = {
      microsoft_enterprise_cloud_monitoring = {
        diagnostic_log_analytics_key = "central_logs_region1"
      }

      microsoft_azure_diagnostics = {
        # Requires at least one diagnostics storage account
        diagnostics_storage_account_keys = ["bootdiag_region1"]

        # Relative path to the configuration folder or full path
        xml_diagnostics_file = "{{ config.destination_install_path }}{{ config.destination_relative_base_path }}/{{ level }}/{{ base_folder }}/diagnostics/wadcfg.xml"
      }
    }
  }
}

diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "boot-dc-re1"
    resource_group_key       = "domaincontrollers_rg"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

