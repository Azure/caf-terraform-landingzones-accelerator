module "caf" {
  source  = "aztfmod/caf/azurerm//landingzones/caf_launchpad"
  version = "5.3.0-preview2"

  azuread_api_permissions               = var.azuread_api_permissions
  azuread_apps                          = var.azuread_apps
  azuread_groups                        = var.azuread_groups
  azuread_roles                         = var.azuread_roles
  azuread_users                         = var.azuread_users
  custom_role_definitions               = var.custom_role_definitions
  dynamic_keyvault_secrets              = var.dynamic_keyvault_secrets
  enable                                = var.enable
  environment                           = var.environment
  event_hub_namespaces                  = var.event_hub_namespaces
  inherit_tags                          = var.inherit_tags
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  keyvaults                             = var.keyvaults
  landingzone                           = var.landingzone
  launchpad_key_names                   = var.launchpad_key_names
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.logged_user_objectId
  managed_identities                    = var.managed_identities
  passthrough                           = var.passthrough
  prefix                                = var.prefix
  random_length                         = var.random_length
  resource_groups                       = var.resource_groups
  regions                               = var.regions
  role_mapping                          = var.role_mapping
  rover_version                         = var.rover_version
  storage_accounts                      = var.storage_accounts
  subscriptions                         = var.subscriptions
  tags                                  = var.tags
  tenant_id                             = var.tenant_id
  user_type                             = var.user_type

  compute = {
    bastion_hosts    = var.bastion_hosts
    virtual_machines = var.virtual_machines
  }

  diagnostics = {
    diagnostic_event_hub_namespaces = var.diagnostic_event_hub_namespaces
    diagnostic_log_analytics        = var.diagnostic_log_analytics
    diagnostic_storage_accounts     = var.diagnostic_storage_accounts
    diagnostics_definition          = var.diagnostics_definition
    diagnostics_destinations        = var.diagnostics_destinations
  }

  networking = {
    azurerm_routes                    = var.azurerm_routes
    network_security_group_definition = var.network_security_group_definition
    public_ip_addresses               = var.public_ip_addresses
    route_tables                      = var.route_tables
    vnets                             = var.vnets
  }
}
