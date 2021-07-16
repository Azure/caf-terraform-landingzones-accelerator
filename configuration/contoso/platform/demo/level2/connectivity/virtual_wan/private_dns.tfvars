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

  }

  #
  # Private DNS zones for Private Links
  #
  "privatelink.adf.azure.com" = {
    name               = "privatelink.adf.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.afs.azure.net" = {
    name               = "privatelink.afs.azure.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.api.azureml.ms" = {
    name               = "privatelink.api.azureml.ms"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.azconfig.io" = {
    name               = "privatelink.azconfig.io"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.azure-automation.net" = {
    name               = "privatelink.azure-automation.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.azure-devices.net" = {
    name               = "privatelink.azure-devices.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.azurecr.io" = {
    name               = "privatelink.azurecr.io"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.azurewebsites.net" = {
    name               = "privatelink.azurewebsites.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.blob.core.windows.net" = {
    name               = "privatelink.blob.core.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.cassandra.cosmos.azure.com" = {
    name               = "privatelink.cassandra.cosmos.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.cognitiveservices.azure.com" = {
    name               = "privatelink.cognitiveservices.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.database.windows.net" = {
    name               = "privatelink.database.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.datafactory.azure.net" = {
    name               = "privatelink.datafactory.azure.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.mariadb.database.azure.com" = {
    name               = "privatelink.mariadb.database.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.mongo.cosmos.azure.com" = {
    name               = "privatelink.mongo.cosmos.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.monitor.azure.com" = {
    name               = "privatelink.monitor.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.mysql.database.azure.com" = {
    name               = "privatelink.mysql.database.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.notebooks.azure.net" = {
    name               = "privatelink.notebooks.azure.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.ods.opinsights.azure.com" = {
    name               = "privatelink.ods.opinsights.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.oms.opinsights.azure.com" = {
    name               = "privatelink.oms.opinsights.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.postgres.database.azure.com" = {
    name               = "privatelink.postgres.database.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.queue.core.windows.net" = {
    name               = "privatelink.queue.core.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.redis.cache.windows.net" = {
    name               = "privatelink.redis.cache.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.search.windows.net" = {
    name               = "privatelink.search.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.service.signalr.net" = {
    name               = "privatelink.service.signalr.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.servicebus.windows.net" = {
    name               = "privatelink.servicebus.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.sql.azuresynapse.net" = {
    name               = "privatelink.sql.azuresynapse.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.table.core.windows.net" = {
    name               = "privatelink.table.core.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.table.cosmos.azure.com" = {
    name               = "privatelink.table.cosmos.azure.com"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.vaultcore.azure.net" = {
    name               = "privatelink.vaultcore.azure.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
  "privatelink.web.core.windows.net" = {
    name               = "privatelink.web.core.windows.net"
    resource_group_key = "contoso_global_dns"
    vnet_links = {
      connectivity_firewall_egress = {
        name     = "connectivity-firewall-egress"
        vnet_key = "connectivity_firewall_egress"
      }
    }
  }
}