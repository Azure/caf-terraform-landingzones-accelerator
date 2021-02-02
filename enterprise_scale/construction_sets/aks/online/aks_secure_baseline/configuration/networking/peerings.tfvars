vnet_peerings = {
  vnet_aks_re1_TO_vnet_hub_re1 = {
    name = "vnet_aks_re1_TO_vnet_hub_re1"
    from = {
      vnet_key = "vnet_aks_re1"
    }
    to = {
      output_key = "vnets"
      vnet_key   = "vnet_hub_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  vnet_hub_re1_TO_vnet_aks_re1 = {
    name = "vnet_hub_re1_TO_vnet_aks_re1"
    from = {
      output_key = "vnets"
      vnet_key   = "vnet_hub_re1"
    }
    to = {
      vnet_key = "vnet_aks_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }

}