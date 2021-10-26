
private_dns = {
  dns1 = {
    name               = "aks-ingress.contoso.com"
    resource_group_key = "aks_spoke_re1"

    records = {
      a_records = {
        ingress = {
          name    = "bu0001a0008-00"
          ttl     = 3600
          records = ["10.100.82.10"]
        }
      }
    }

    vnet_links = {
      link_aks = {
        name     = "aks-vnet-link"
        vnet_key = "vnet_aks_re1"
      }
    }
  }
}