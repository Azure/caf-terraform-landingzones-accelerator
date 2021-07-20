virtual_hub_connections = {
  adds-re1-to-hub1 = {
    name = "adds-re1-to-hub1"
    virtual_hub = {
      lz_key = "connectivity_virtual_hub1"
      key    = "hub1"
    }
    vnet = {
      vnet_key = "identity_adds"
    }
    routing = {
      routetable1 = {
        virtual_hub_route_table_key    = "routetable1"
        lz_key = "connectivity_virtual_hub1"

        propagated_route_table = {
          lz_key = "connectivity_virtual_hub1"
          virtual_hub_route_table_keys = ["routetable1"]
          labels = ["contoso-demo", "wan"]
        }
      }
    }
  }
}