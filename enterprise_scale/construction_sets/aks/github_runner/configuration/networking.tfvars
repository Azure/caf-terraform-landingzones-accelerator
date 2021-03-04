vnets = {
  vnet_aks_re1 = {
    resource_group_key = "aks_spoke_re1"
    region             = "region1"
    vnet = {
      name          = "aks"
      address_space = ["10.100.80.0/20"]
    }
    subnets = {
      aks_nodepool_system = {
        name            = "aks_nodepool_system"
        cidr            = ["10.100.80.0/24"]
      }
      aks_nodepool_user1 = {
        name            = "aks_nodepool_user1"
        cidr            = ["10.100.81.0/24"]
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
