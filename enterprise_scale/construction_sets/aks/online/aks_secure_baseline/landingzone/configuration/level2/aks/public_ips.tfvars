public_ip_addresses = {
  agw_pip1_re1 = {
    name                    = "agw_pip1"
    resource_group_key      = "agw_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    zones                   = ["1"]
    idle_timeout_in_minutes = "4"
  }
}
