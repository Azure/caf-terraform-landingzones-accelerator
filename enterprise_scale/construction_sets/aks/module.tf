module "caf" {
  source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git?ref=master"
  # source  = "aztfmod/caf/azurerm"
  # version = "~> 5.0.0"

  global_settings      = var.global_settings
  logged_user_objectId = var.logged_user_objectId
  tags                 = var.tags
  resource_groups      = var.resource_groups
  azuread_apps         = var.azuread_apps
  azuread_users        = var.azuread_users
  azuread_groups       = var.azuread_groups
  keyvaults            = var.keyvaults
  role_mapping         = var.role_mapping

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

  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_log_analytics = var.diagnostic_log_analytics
  }

  compute = {
    aks_clusters     = var.aks_clusters
    virtual_machines = var.virtual_machines
  }

  security = {
    keyvault_certificate_requests = var.keyvault_certificate_requests
  }
}
