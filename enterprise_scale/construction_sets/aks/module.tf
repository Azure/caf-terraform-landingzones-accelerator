module "caf" {
  # source  = "aztfmod/caf/azurerm"
  # version = "~> 4.22.0"
  source = "/tf/caf/aztfmod"

  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups
  azuread_apps    = var.azuread_apps
  azuread_users   = var.azuread_users
  azuread_groups  = var.azuread_groups
  keyvaults       = var.keyvaults
  role_mapping    = var.role_mapping

  networking = {
    azurerm_firewalls                                       = var.azurerm_firewalls
    azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition
    azurerm_firewall_network_rule_collection_definition     = var.azurerm_firewall_network_rule_collection_definition
    azurerm_routes                                          = var.azurerm_routes
    network_security_group_definition                       = var.network_security_group_definition
    public_ip_addresses                                     = var.public_ip_addresses
    route_tables                                            = var.route_tables
    vnets                                                   = var.vnets
  }

  compute = {
    aks_clusters     = var.aks_clusters
    virtual_machines = var.virtual_machines
  }

}