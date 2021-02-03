azurerm_firewalls = {
  fw_re1 = {
    name               = "egress"
    resource_group_key = "vnet_hub_re1"
    vnet_key           = "hub_re1"
    public_ip_key      = "firewall_re1"

    # you can setup up to 5 keys - vnet diganostic
    # diagnostic_profiles = {
    #   operation = {
    #     definition_key   = "azurerm_firewall"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }

    azurerm_firewall_network_rule_collections = [
      "aks"
    ]

    azurerm_firewall_application_rule_collections = [
      "aks",
      "packages"
    ]
  }
}


