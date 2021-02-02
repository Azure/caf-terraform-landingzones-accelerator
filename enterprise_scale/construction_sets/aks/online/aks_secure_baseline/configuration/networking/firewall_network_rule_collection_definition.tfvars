
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
          "*"
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
      apiservertcp = {
        name = "apiservertcp"
        source_addresses = [
          "*",
        ]
        destination_ports = [
          "443","9000","22"
        ]
        destination_addresses = [
          "AzureCloud"
        ]
        protocols = [
          "TCP",
        ]
      },
      apiserverudp = {
        name = "apiserverudp"
        source_addresses = [
          "*",
        ]
        destination_ports = [
          "1194"
        ]
        destination_addresses = [
          "AzureCloud"
        ]
        protocols = [
          "UDP",
        ]
      },
    }
  }
}