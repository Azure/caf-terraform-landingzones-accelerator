
azurerm_firewall_network_rule_collection_definition = {
  aks = {
    name     = "aks"
    action   = "Allow"
    priority = 150
    ruleset = {
      ntp = {
        name = "ntp"
        source_addresses = [
          "*",
        ]
        destination_ports = [
          "123",
        ]
        destination_addresses = [
          "91.189.89.198", "91.189.91.157", "91.189.94.4", "91.189.89.199"
        ]
        protocols = [
          "UDP",
        ]
      },
      monitor = {
        name = "monitor"
        source_addresses = [
          "*",
        ]
        destination_ports = [
          "443",
        ]
        destination_addresses = [
          "AzureMonitor"
        ]
        protocols = [
          "TCP",
        ]
      },
    }
  }
}