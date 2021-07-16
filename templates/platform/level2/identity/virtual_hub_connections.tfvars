virtual_hub_connections = {
  #region 1
  vpr-uglife-dev-az1-aks-to-san-vhub = {
    name = "vpr-uglife-dev-az1-aks-to-san-vhub"
    virtual_hub = {
      lz_key = "platform_phb_vhub_san"
      key    = "san"
    }
    vnet = {
      lz_key   = "dev_landingzone"
      vnet_key = "az1_aks_vnet"
    }
    routing = {
      virtual_hub_route_table = {
        key    = "uglife"
        lz_key = "platform_phb_vhub_san"
      }
      propagated_route_table = {
        route_tables = {
          uglife = {
            key    = "uglife"
            lz_key = "platform_phb_vhub_san"
          }
        }
        labels = ["africa", "wan"]
      }
    }
  }
}