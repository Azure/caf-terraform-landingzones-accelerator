# #
# # Define the settings for the diagnostics settings
# # Demonstrate how to log diagnostics in the correct region
# # Different profiles to target different operational teams
# #
# diagnostics_definition = {
#   azurerm_firewall = {
#     name = "operational_logs_and_metrics"
#     categories = {
#       log = [
#         #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#         ["AzureFirewallApplicationRule", true, true, 7],
#         ["AzureFirewallNetworkRule", true, true, 7],
#         ["AzureFirewallDnsProxy", true, true, 7],
#       ]
#       metric = [
#         ["AllMetrics", true, true, 7],
#       ]
#     }
#   }

#   public_ip_address = {
#     name = "operational_logs_and_metrics"
#     categories = {
#       log = [
#         #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#         ["DDoSProtectionNotifications", true, true, 7],
#         ["DDoSMitigationFlowLogs", true, true, 7],
#         ["DDoSMitigationReports", true, true, 7],
#       ]
#       metric = [
#         ["AllMetrics", true, true, 7],
#       ]
#     }
#   }

#   network_security_group = {
#     name = "operational_logs_and_metrics"
#     categories = {
#       log = [
#         # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#         ["NetworkSecurityGroupEvent", true, false, 7],
#         ["NetworkSecurityGroupRuleCounter", true, false, 7],
#       ]
#     }

#   }
# }

# diagnostics_destinations = {
#   # Storage keys must reference the azure region name
#   storage = {
#     all_regions = {
#       southeastasia = {
#         storage_account_key = "diagsiem_region1"
#       }
#     }
#   }

#   log_analytics = {
#     central_logs = {
#       log_analytics_key              = "central_logs_region1"
#       log_analytics_destination_type = "Dedicated"
#     }
#   }
# }


# diagnostic_storage_accounts = {
#   # Stores diagnostic logging for region1
#   diaglogs_region1 = {
#     name                     = "diaglogsrg1"
#     region                   = "region1"
#     resource_group_key       = "ops"
#     account_kind             = "BlobStorage"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Cool"
#   }
#   # Stores security logs for siem default region"
#   diagsiem_region1 = {
#     name                     = "siemsg1"
#     resource_group_key       = "siem"
#     account_kind             = "BlobStorage"
#     account_tier             = "Standard"
#     account_replication_type = "LRS"
#     access_tier              = "Cool"
#   }
# }