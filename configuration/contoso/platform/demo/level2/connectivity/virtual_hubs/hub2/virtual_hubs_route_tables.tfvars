virtual_hub_route_tables = {
  routetable1 = {
    name = "example-vhubroutetable1"

    virtual_hub = {
      key = "hub2"
    }

    labels = ["label1"]
    routes = {
      # egress_internet = {
      #   name              = "egress-internet"
      #   destinations_type = "CIDR"
      #   destinations      = ["0.0.0.0/0"]

      #   # Either next_hop or next_hop_id can be used
      #   #
      #   # When using next_hop, the virtual_hub_connection must be deployed in a different landingzone. This cannot be tested in the standalone module.
      #   # Will be covered in the landingzone starter production configuration in future releases.
      #   #
      #   next_hop = {
      #     lz_key = "" #
      #     resource_type = "virtual_hub_connection"  # Only supported value.
      #     resource_key  = "egress-fw"
      #   }
      #   #to cather for external object
      #   #next_hop_id       = "Azure_Resource_ID"
      # }
    }
  }
  routetable2 = {
    name = "example-vhubroutetable2"

    virtual_hub = {
      key = "hub2"
    }

    labels = ["label2"]
  }
}
