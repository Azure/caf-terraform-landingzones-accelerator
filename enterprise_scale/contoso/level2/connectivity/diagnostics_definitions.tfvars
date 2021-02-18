#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  azurerm_firewall = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, true, 7],
        ["AzureFirewallNetworkRule", true, true, 7],
        ["AzureFirewallDnsProxy", true, true, 7],
      ]
      metric = [
        ["AllMetrics", true, true, 7],
      ]
    }
  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, true, 7],
        ["DDoSMitigationFlowLogs", true, true, 7],
        ["DDoSMitigationReports", true, true, 7],
      ]
      metric = [
        ["AllMetrics", true, true, 7],
      ]
    }
  }

  azure_container_registry = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ContainerRegistryRepositoryEvents", true, false, 7],
        ["ContainerRegistryLoginEvents", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }

}
