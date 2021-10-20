virtual_hubs = {
  hub2 = {
    virtual_wan = {
      lz_key = "connectivity_virtual_wan"
      key    = "contoso_global_wan"
    }

    resource_group = {
      lz_key = "connectivity_virtual_wan"
      key    = "contoso_global_wan"
    }

    hub_name           = "hub2"
    region             = "region2"
    hub_address_prefix = "10.11.0.0/24"
    deploy_firewall    = false
    deploy_p2s         = false
    p2s_config         = {}
    deploy_s2s         = false
    s2s_config         = {}
    deploy_er          = false
  }
}

