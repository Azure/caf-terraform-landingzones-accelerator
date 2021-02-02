vnets = {
  vnet_hub_re1 = {
    resource_group_key = "vnet_hub_re1"
    region             = "region1"
    vnet = {
      name          = "vnet_hub_re1"
      address_space = ["100.64.100.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.64.100.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.64.101.0/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.64.101.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.64.102.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.103.128/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
  vnet_aks_re1 = {
    resource_group_key = "aks_spoke_re1"
    region             = "region1"
    vnet = {
      name          = "aks"
      address_space = ["10.100.80.0/22"]
    }
    subnets = {
      aks_nodepool_system = {
        name            = "aks_nodepool_system"
        cidr            = ["10.100.80.0/24"]
        nsg_key         = "azure_kubernetes_cluster_nsg"
        route_table_key = "default_to_firewall_re1"
      }
      aks_nodepool_user1 = {
        name            = "aks_nodepool_user1"
        cidr            = ["10.100.81.0/24"]
        nsg_key         = "azure_kubernetes_cluster_nsg"
        route_table_key = "default_to_firewall_re1"
      }
      aks_ingress = {
        name            = "aks_ingress"
        cidr            = ["10.100.82.0/24"]
        nsg_key         = "azure_kubernetes_cluster_nsg"
        route_table_key = "default_to_firewall_re1"
      }
      jumpbox = {
        name            = "jumpbox"
        cidr            = ["10.100.83.64/28"]
        nsg_key         = "azure_kubernetes_cluster_nsg"
        route_table_key = "default_to_firewall_re1"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["10.100.83.0/27"]
        enforce_private_link_endpoint_network_policies = true
      }
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["10.100.83.32/27"]
        nsg_key = "azure_bastion_nsg"
      }
      application_gateway = {
        name    = "agw"
        cidr    = ["10.100.83.96/27"]
        nsg_key = "application_gateway"
      }
    } //subnets


    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["10.100.83.128/26"]
      }
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["10.100.83.224/27"]
      }
    } //specialsubnets

  }
} //vnets
