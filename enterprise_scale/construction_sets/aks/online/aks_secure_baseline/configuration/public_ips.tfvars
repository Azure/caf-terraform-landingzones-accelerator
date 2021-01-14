public_ip_addresses = {
  firewall_re1 = {
    name                    = "egress-pip1"
    resource_group_key      = "aks_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }

  bastion_host_re1 = {
    name                    = "bastion-pip1"
    resource_group_key      = "aks_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}