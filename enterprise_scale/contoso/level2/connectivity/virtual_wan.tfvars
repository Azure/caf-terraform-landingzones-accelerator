virtual_wans = {
  vwan_re1 = {
    resource_group_key = "contoso_global_wan"
    name               = "contosovWAN-re1"
    region             = "region1"

    hubs = {
      hub_re1 = {
        hub_name                    = "contoso-vhub-sea"
        region                      = "region1"
        hub_address_prefix          = "10.2.0.0/24"
        deploy_firewall             = true
        firewall_name               = "hub-fw-re1"
        firewall_resource_group_key = "hub_re1"
        deploy_p2s                  = false
        p2s_config                  = {}
        deploy_s2s                  = false
        s2s_config                  = {}
        deploy_er                   = true
        er_config = {
          name        = "caf-sea-er"
          scale_units = 1
        }

      }

      # hub_re2 = {
      #   hub_name                    = "hub-re2"
      #   region                      = "region2"
      #   hub_address_prefix          = "10.0.4.0/24"
      #   deploy_firewall             = true
      #   firewall_name               = "hub-fw-re2"
      #   firewall_resource_group_key = "hub_re2"
      #   deploy_p2s                  = false
      #   p2s_config                  = {}
      #   deploy_s2s                  = false
      #   s2s_config                  = {}
      #   deploy_er                   = false
      #   er_config                   = {}
      # }
    }
  }
}

