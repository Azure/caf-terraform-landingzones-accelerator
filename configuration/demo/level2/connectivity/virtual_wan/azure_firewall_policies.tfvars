azurerm_firewall_policies = {
  policy1 = {
    name               = "firewall_policy"
    resource_group_key = "contoso_global_wan"
    region             = "region1"
  }
}

azurerm_firewall_policy_rule_collection_groups = {
  group1 = {
    #firewall_policy_id = "Azure Resource ID"
    firewall_policy_key = "policy1"
    name                = "example-fwpolicy-rcg"
    priority            = 500

    application_rule_collections = {
      rule1 = {
        name     = "app_rule_collection1"
        priority = 500
        action   = "Deny"
        rules = {
          rule1 = {
            name = "app_rule_collection1_rule1"
            protocols = {
              1 = {
                type = "Http"
                port = 80
              }
              2 = {
                type = "Https"
                port = 443
              }
            }
            source_addresses  = ["10.0.0.1"]
            destination_fqdns = ["*.microsoft.com"]
          }
        }
      }
    }


  }
}