azurerm_firewall_policies = {
  policy1 = {
    name   = "Base policy"
    region = "region1"
    resource_group = {
      key    = "contoso_global_firewall_policies"
    }
    dns = {
      proxy_enabled = "true"
    }
    threat_intelligence_mode = "Alert"
    threat_intelligence_allowlist = {
      fqdns = ["microsoft.com", "demo.com"]
    }
  }
}
