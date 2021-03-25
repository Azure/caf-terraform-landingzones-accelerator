vnet_peerings = {
  #
  # Peering Region1
  #
  spoke_aks_re1_TO_hub_re1 = {
    name = "spoke_aks_re1_TO_hub_re1"
    from = {
      vnet_key = "spoke_aks_re1"
    }
    to = {
      lz_key     = "networking_hub"
      output_key = "vnets"
      vnet_key   = "hub_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_re1_TO_spoke_aks_re1 = {
    name = "hub_re1_TO_spoke_aks_re1"
    from = {
      lz_key     = "networking_hub"
      output_key = "vnets"
      vnet_key   = "hub_re1"
    }
    to = {
      vnet_key = "spoke_aks_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }

  #
  # Peering Region2
  #
  spoke_aks_re2_TO_hub_re2 = {
    name = "spoke_aks_re2_TO_hub_re2"
    from = {
      vnet_key = "spoke_aks_re2"
    }
    to = {
      lz_key     = "networking_hub"
      output_key = "vnets"
      vnet_key   = "hub_re2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_re2_TO_spoke_aks_re2 = {
    name = "hub_re2_TO_spoke_aks_re2"
    from = {
      lz_key     = "networking_hub"
      output_key = "vnets"
      vnet_key   = "hub_re2"
    }
    to = {
      vnet_key = "spoke_aks_re2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }

}