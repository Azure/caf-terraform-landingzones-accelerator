
variable "global_settings" {
  description = "Global settings object for the current deployment."
  default = {
    passthrough    = false
    random_length  = 4
    default_region = "region1"
    regions = {
      region1 = "southeastasia"
    }
  }
}

variable "resource_groups" {
  default = {}
}

variable "vnets" {
  default = {}
}

variable "tags" {
  default = {}
}

variable "aks_clusters" {
  default = {}
}

variable "diagnostic_log_analytics" {
  default = {}
}

variable "virtual_machines" {
  default = {}
}

variable "network_security_group_definition" {
  default = {}
}

variable "azuread_users" {
  default = {}
}

variable "azuread_apps" {
  default = {}
}

variable "azuread_groups" {
  default = {}
}

variable "role_mapping" {
  default = {}
}

variable "keyvaults" {
  default = {}
}

variable "azurerm_firewalls" {
  default = {}
}

variable "azurerm_firewall_application_rule_collection_definition" {
  default = {}
}

variable "azurerm_firewall_network_rule_collection_definition" {
  default = {}
}

variable "public_ip_addresses" {
  default = {}
}

variable "route_tables" {
  default = {}
}

variable "azurerm_routes" {
  default = {}
}

variable "logged_user_objectId" {
  default = {}
}

variable "keyvault_certificate_requests" {
  default = {}
}
