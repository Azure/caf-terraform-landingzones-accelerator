private_dns = {
  dns1 = {
    name               = "test-dns.contoso_private.com"
    resource_group_key = "contoso_global_dns"

    records = {
      a_records = {
        testa1 = {
          name    = "*"
          ttl     = 3600
          records = ["1.1.1.1", "2.2.2.2"]
        }
        testa2 = {
          name    = "@"
          ttl     = 3600
          records = ["1.1.1.1", "2.2.2.2"]
        }
      }

      txt_records = {
        testtxt1 = {
          name = "testtxt1"
          ttl  = 3600
          records = {
            r1 = {
              value = "testing txt 1"
            }
            r2 = {
              value = "testing txt 2"
            }
          }
        }
      }
    }

    # vnet_links = {
    #   link_test = {
    #     name     = "test-vnet-link"
    #     vnet_key = "vnet_test"
    #   }
    #   # link_hub = {
    #   #   name = "hub-vnet-link"
    #   #   remote_tfstate = {
    #   #     tfstate_key = "networking_hub"
    #   #     lz_key      = "networking_hub"
    #   #     output_key  = "vnets"
    #   #     vnet_key    = "hub_rg1"
    #   #   }
    #   # }
    # }
  }
}