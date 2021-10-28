azurerm_firewalls = {
  fw_re1 = {
    name               = "egress"
    resource_group_key = "vnet_hub_re1"
    vnet_key           = "vnet_hub_re1"
    # public_ip_key      = "firewall_re1" # if this is defined, public_ip_keys is ignored
    public_ip_keys = ["firewall_re1", "firewall_pip2_re1"]

    azurerm_firewall_network_rule_collections = [
      "aks"
    ]

    azurerm_firewall_application_rule_collections = [
      "aks",
      "packages"
    ]
  }
}


