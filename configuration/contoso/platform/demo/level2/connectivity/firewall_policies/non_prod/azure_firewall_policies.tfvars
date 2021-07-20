azurerm_firewall_policies = {
  non_prod = {
    name   = "non-production"
    region = "region1"
    resource_group = {
      key    = "contoso_global_firewall_policies"
      lz_key = "connectivity_firewall_policy_root"
    }
    base_policy    = {
      key    = "root"
      lz_key = "connectivity_firewall_policy_root"
    }
  }
}
