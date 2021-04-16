vnets = {
  spoke_aks_re1 = {
    resource_group_key = "aks_spoke_re1"
    region             = "region1"
    vnet = {
      name          = "aks-re1"
      address_space = ["100.64.48.0/22"]
    }
    specialsubnets = {}
    subnets = {
      aks_nodepool_system = {
        name    = "aks_nodepool_system"
        cidr    = ["100.64.48.0/24"]
        nsg_key = "azure_kubernetes_cluster_nsg"
      }
      aks_nodepool_user1 = {
        name    = "aks_nodepool_user1"
        cidr    = ["100.64.49.0/24"]
        nsg_key = "azure_kubernetes_cluster_nsg"
      }
      aks_nodepool_user2 = {
        name    = "aks_nodepool_user2"
        cidr    = ["100.64.50.0/24"]
        nsg_key = "azure_kubernetes_cluster_nsg"
      }
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.64.51.64/27"]
        nsg_key = "azure_bastion_nsg"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.51.0/27"]
        enforce_private_link_endpoint_network_policies = true
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.64.51.128/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }

  }

  spoke_aks_re2 = {
    resource_group_key = "aks_spoke_re2"
    region             = "region2"
    vnet = {
      name          = "aks-re2"
      address_space = ["100.65.48.0/22"]
    }
    specialsubnets = {}
    subnets = {
      aks_nodepool_system = {
        name    = "aks_nodepool_system"
        cidr    = ["100.65.48.0/24"]
        nsg_key = "azure_kubernetes_cluster_nsg"
      }
      aks_nodepool_user1 = {
        name    = "aks_nodepool_user1"
        cidr    = ["100.65.49.0/24"]
        nsg_key = "azure_kubernetes_cluster_nsg"
      }
      aks_nodepool_user2 = {
        name    = "aks_nodepool_user2"
        cidr    = ["100.65.50.0/24"]
        nsg_key = "azure_kubernetes_cluster_nsg"
      }
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.65.51.64/27"]
        nsg_key = "azure_bastion_nsg"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.65.51.0/27"]
        enforce_private_link_endpoint_network_policies = true
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.65.51.128/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }

  }
}