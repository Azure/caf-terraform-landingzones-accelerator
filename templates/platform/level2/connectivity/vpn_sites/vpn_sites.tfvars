vpn_sites = {

  #
  # Prod
  #

  prod = {
    name = "Production"
    resource_group = {
      lz_key = "connectivity_virtual_wan"
      key    = "global_wan"
    }
    device_vendor = "checkpoint"
    virtual_wan = {
      lz_key = "connectivity_virtual_wan"
      key    = "global_wan"
    }
    links = {
      primary = {
        name          = "primary"
        ip_address    = "202.152.224.2" // checkpoint public ip address
        provider_name = "Microsoft"
        speed_in_mbps = "100"
      }
    }
  }

  #
  # Dev
  #

  dev = {
    name = "Development"
    resource_group = {
      lz_key = "connectivity_virtual_wan"
      key    = "global_wan"
    }
    device_vendor = "checkpoint"
    virtual_wan = {
      lz_key = "connectivity_virtual_wan"
      key    = "global_wan"
    }
    links = {
      primary = {
        name          = "primary"
        ip_address    = "202.152.224.2" // checkpoint public ip address
        provider_name = "Microsoft"
        speed_in_mbps = "100"
      }
    }
  }

}

