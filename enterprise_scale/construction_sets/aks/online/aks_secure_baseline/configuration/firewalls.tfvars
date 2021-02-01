azurerm_firewalls = {
  fw_re1 = {
    name               = "egress"
    resource_group_key = "aks_re1"
    vnet_key           = "vnet_aks_re1"
    public_ip_key      = "firewall_re1"

    azurerm_firewall_network_rule_collections = [
      "aks"
    ]

    azurerm_firewall_application_rule_collections = [
      "aks",
      "packages"
    ]
  }
}


