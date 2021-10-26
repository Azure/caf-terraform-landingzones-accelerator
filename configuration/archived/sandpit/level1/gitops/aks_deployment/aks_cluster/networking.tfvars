vnets = {
  vnet_gitops = {
    resource_group_key = "gitops"
    region             = "region1"
    vnet = {
      name          = "gitops-aks"
      address_space = ["10.200.200.0/23"]
    }
    # dns_servers = ["10.192.51.164", "10.192.51.165"]
    subnets = {
      aks_nodepool_system = {
        name                                           = "gitops-aks-nodepool"
        cidr                                           = ["10.200.200.0/25"]
        nsg_key                                        = "azure_kubernetes_cluster_nsg"
        enforce_private_link_endpoint_network_policies = true
        # route_table_key = "default_to_firewall_re1"
      }
      aks_runners = {
        name = "gitops-aks-aks_runner"
        cidr    = ["10.200.200.128/25"]
        nsg_key = "azure_kubernetes_cluster_nsg"
        # route_table_key = "default_to_firewall_re1"
      }
      private_endpoints = {
        name = "gitops-aks-private_endpoints"
        cidr                                           = ["10.200.201.0/28"]
        enforce_private_link_endpoint_network_policies = true
      }
    } //subnets

  }
} //vnets

