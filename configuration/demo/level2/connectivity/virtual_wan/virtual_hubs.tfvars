virtual_hubs = {
  hub_re1 = {
    virtual_wan = {
      # lz_key = "" # for remote deployment
      key = "vwan_re1"
    }

    resource_group = {
      # lz_key = "" # for remote deployment
      key = "contoso_global_wan"
    }

    hub_name           = "hub-re1"
    region             = "region1"
    hub_address_prefix = "10.0.3.0/24"
    deploy_firewall    = false
    deploy_p2s         = false
    p2s_config         = {}
    deploy_s2s         = false
    s2s_config         = {}
    deploy_er          = false
  }
}

