vnets = {
  connectivity_hub1_firewall_egress = {
    resource_group_key = "contoso_global_firewall"
    vnet = {
      name          = "firewall-egress-re1"
      address_space = ["10.10.10.0/24", "10.10.11.0/24"]
    }
    subnets = {
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet"
        cidr = ["10.10.10.0/26"]
      }
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