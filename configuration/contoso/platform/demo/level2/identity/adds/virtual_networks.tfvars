vnets = {
  identity_adds = {
    resource_group_key = "contoso_identity_adds"
    vnet = {
      name          = "adds-re1"
      address_space = ["10.10.20.0/24"]
    }
    subnets = {
      ActiveDirectory = {
        name    = "ADSubnet"
        cidr    = ["10.10.20.0/27"]
        nsg_key = "empty_nsg"
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}