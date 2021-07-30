bastion_hosts = {
  bastion_hub_re1 = {
    name               = "bastion-re1"
    region             = "region1"
    resource_group_key = "jumpbox_re1"
    vnet_key           = "vnet_aks_re1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_re1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}

# Virtual machines
virtual_machines = {
  windows_server1 = {
    resource_group_key                   = "jumpbox_re1"
    provision_vm_agent                   = true

    os_type = "windows"

    # when not set the password is auto-generated and stored into the keyvault
    keyvault_key = "secrets"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        vnet_key                = "vnet_aks_re1"
        subnet_key              = "jumpbox"
        name                    = "0-server1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "server1-nic0"

      }
    }

    virtual_machine_settings = {
      windows = {
        name           = "server1"
        size           = "Standard_F2s_v2"
        admin_username = "adminuser"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "server1-os"
          caching              = "ReadWrite"
          create_option        = "FromImage"
          storage_account_type = "Standard_LRS"
          managed_disk_type    = "StandardSSD_LRS"
          disk_size_gb         = "128"
        }

        source_image_reference = {
          publisher = "MicrosoftWindowsServer"
          offer     = "WindowsServer"
          sku       = "2019-Datacenter"
          version   = "latest"
        }

      }
    }

  }
}