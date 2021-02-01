vnets = {
  ase_region1 = {
    resource_group_key = "networking_ase"
    vnet = {
      name          = "ase"
      address_space = ["172.25.176.0/23"]
    }
    specialsubnets = {}
    subnets = {
      ase1 = {
        name              = "ase1"
        cidr              = ["172.25.176.0/25"]
        service_endpoints = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.EventHub"]
        nsg_key           = "ase"
        route_table_key   = "default_internet"
      }
      ase2 = {
        name              = "ase2"
        cidr              = ["172.25.176.128/25"]
        service_endpoints = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.EventHub"]
        nsg_key           = "ase"
        route_table_key   = "default_internet"
      }
      ase3 = {
        name              = "ase3"
        cidr              = ["172.25.177.0/25"]
        service_endpoints = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.EventHub"]
        nsg_key           = "ase"
        route_table_key   = "default_internet"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["172.25.177.128/26"]
        enforce_private_link_endpoint_network_policies = true
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["172.25.177.192/29"]
        nsg_key = "jumpbox"
      }
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["172.25.177.200/29"]
        nsg_key = "azure_bastion_nsg"
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    # diagnostic_profiles = {
    #   vnet = {
    #     definition_key   = "networking_all"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }

  }
}