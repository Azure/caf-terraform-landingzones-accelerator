
# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  level0 = {
    resource_group_key                   = "rg0"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    keyvault_key = "sshl0"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "gitops_connectivity"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level0"
        name                    = "0-release-agent-level0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level0"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level0-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"

          remote = {
            launchpad = {
              managed_identity_keys = [
                "level0",
              ]
            }
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level0"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
  level1 = {
    resource_group_key                   = "rg1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    keyvault_key = "sshl1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "gitops_connectivity"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level1"
        name                    = "0-release-agent-level1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level1"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level1"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"

          remote = {
            launchpad = {
              managed_identity_keys = [
                "level1",
              ]
            }
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level1"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
  level2 = {
    resource_group_key                   = "rg2"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    keyvault_key = "sshl2"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "gitops_connectivity"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level2"
        name                    = "0-release-agent-level2"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level2"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level2"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level2-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"

          remote = {
            launchpad = {
              managed_identity_keys = [
                "level2",
              ]
            }
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level2"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
  level3 = {
    resource_group_key                   = "rg3"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    keyvault_key = "sshl3"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "gitops_connectivity"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level3"
        name                    = "0-release-agent-level3"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level3"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level3"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level3-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"

          remote = {
            launchpad = {
              managed_identity_keys = [
                "level3",
              ]
            }
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level3"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
  level4 = {
    resource_group_key                   = "rg4"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    keyvault_key = "sshl4"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "gitops_connectivity"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level4"
        name                    = "0-release-agent-level4"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level4"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level4"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level4-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"

          remote = {
            launchpad = {
              managed_identity_keys = [
                "level4",
              ]
            }
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level4"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
}
