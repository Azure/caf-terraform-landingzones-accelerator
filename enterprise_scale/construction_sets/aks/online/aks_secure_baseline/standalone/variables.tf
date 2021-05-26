
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

variable "diagnostics_destinations" {
  default = {}
}

variable "diagnostics_definition" {
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
  default = null
}

variable "keyvault_certificate_requests" {
  default = {}
}

variable "managed_identities" {
  default = {}
}

variable "bastion_hosts" {
  default = {}
}

variable "private_dns" {
  default = {}
}

variable "domain_name_registrations" {
  default = {}
}

variable "dns_zone_records" {
  default = {}
}

variable "dns_zones" {
  default = {}
}

variable "application_gateways" {
  default = {}
}

variable "application_gateway_applications" {
  default = {}
}

variable "vnet_peerings" {
  default = {}
}

variable "ip_groups" {
  default = {}
}

variable "override_prefix" {
  default = ""
}

variable "flux_namespace" {
  type    = string
  default = ""
}

variable "flux_auth_secret" {
  type    = string
  default = ""
}

variable "github_owner" {
  type        = string
  description = "github owner"
  default     = ""
}

variable "github_token" {
  type        = string
  description = "github token"
  default     = ""
}


variable "repository_name" {
  type        = string
  description = "github repository name (without owner)"
  default     = ""
}

variable "repository_visibility" {
  type        = string
  description = "how visible is the github repo"
  default     = ""
}

variable "branch" {
  type        = string
  description = "branch name"
  default     = ""
}

variable "target_install_path" {
  type        = string
  description = "flux install target path"
  default     = ""
}

variable "target_sync_path" {
  type        = string
  description = "flux sync target path"
  default     = ""
}

