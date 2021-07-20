
virtual_hub_connections = {

  # Establish the peering with Virtual Hubs

  con1 = {
    name                      = "vnet1-con1"
    internet_security_enabled = true

    virtual_hub = {
      key = "hub_re1"
    }

    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      vnet_key = "vnet1_region1"
    }

    routing = {
      route1 = {
        virtual_hub_route_table_key = "routetable1"

        propagated_route_table = {
          virtual_hub_route_table_keys = [
            "routetable1"
          ]
          # ids = [
          #   "/subscriptions/{subscriptionId}/resourceGroups/testRG/providers/Microsoft.Network/virtualHubs/westushub/hubRouteTables/defaultRouteTable"
          # ]
          labels = ["test", "test1"]
        }

        static_vnet_route = {
          egress_internet = {
            name = "egress-internet"
            address_prefixes = [
              "0.0.0.0/0"
            ]


            # Either next_hop or next_hop_ip_address can be used
            next_hop = {
              # lz_key = "" #
              key             = "egress-fw"
              interface_index = 0 # Required.
            }

            # next_hop_ip_address = "192.34.23.11"
          }
        }

      }
    }
  }
  con2 = {
    name                      = "identity-vnet"
    internet_security_enabled = true

    virtual_hub = {
      key = "hub_re1"
    }

    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      vnet_key = "identity_vnet"
      lz_key   = "identity"
    }

    routing = {
      route1 = {
        virtual_hub_route_table_key = "routetable1"

        propagated_route_table = {
          virtual_hub_route_table_keys = [
            "routetable1"
          ]
          # ids = [
          #   "/subscriptions/{subscriptionId}/resourceGroups/testRG/providers/Microsoft.Network/virtualHubs/westushub/hubRouteTables/defaultRouteTable"
          # ]
          labels = ["test", "test1"]
        }

        static_vnet_route = {
          egress_internet = {
            name = "egress-internet"
            address_prefixes = [
              "0.0.0.0/0"
            ]


            # Either next_hop or next_hop_ip_address can be used
            next_hop = {
              # lz_key = "" #
              key             = "egress-fw"
              interface_index = 0 # Required.
            }

            # next_hop_ip_address = "192.34.23.11"
          }
        }

      }
    }
  }
  # con2 = {
  #   name                      = "vnet2-con2"
  #   internet_security_enabled = true

  #   virtual_hub = {
  #     key = "hub_re1"
  #   }

  #   vnet = {
  #     # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
  #     vnet_key = "vnet2_region1"
  #   }

  #   routing = {
  #     route1 = {
  #       virtual_hub_route_table_key = "routetable2"

  #       propagated_route_table = {
  #         # lz_keys = ""
  #         virtual_hub_route_table_keys = [
  #           "routetable2"
  #         ]
  #         # ids = [
  #         #   "/subscriptions/{subscriptionId}/resourceGroups/testRG/providers/Microsoft.Network/virtualHubs/westushub/hubRouteTables/defaultRouteTable"
  #         # ]
  #         labels = [
  #           "test2"
  #         ]
  #       }

  #       static_vnet_route = {
  #         # crm = {
  #         #   name = "crm"
  #         #   address_prefixes  = [
  #         #     "10.12.13.0/21"
  #         #   ]
  #         #   next_hop_ip_address = "192.34.23.11"
  #         # }
  #       }

  #     }
  #   }
  # }

}