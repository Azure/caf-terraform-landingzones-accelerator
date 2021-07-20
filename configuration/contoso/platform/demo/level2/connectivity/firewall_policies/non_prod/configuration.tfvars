landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "management"
  level               = "level2"
  key                 = "connectivity_firewall_policy_non_prod"
  tfstates = {
    management = {
      level   = "lower"
      tfstate = "management.tfstate"
    }
    connectivity_firewall_policy_root = {
      level   = "current"
      tfstate = "connectivity_firewall_policy_root.tfstate"
    }
  }
}