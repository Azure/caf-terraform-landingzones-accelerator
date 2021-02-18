vnets = {
  identity_vnet = {
    resource_group_key = "network_rg"
    region             = "region1"
    vnet = {
      name          = "identity-network"
      address_space = ["100.64.92.0/22"]
    }
    subnets = {
      # AzureBastionSubnet = {
      #   name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
      #   cidr    = ["100.64.93.64/26"]
      #   nsg_key = "azure_bastion_nsg"
      # }
      ActiveDirectory = {
        name    = "ADSubnet"
        cidr    = ["100.64.94.0/27"]
        nsg_key = "jumpbox"
      }
      # private_endpoints = {
      #   name                                           = "private_endpoints"
      #   cidr                                           = ["100.64.95.128/25"]
      #   enforce_private_link_endpoint_network_policies = true
      #   nsg_key                                        = "empty_nsg"
      # }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}