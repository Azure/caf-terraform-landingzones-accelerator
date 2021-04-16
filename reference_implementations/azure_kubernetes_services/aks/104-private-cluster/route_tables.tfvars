route_tables = {
  default_to_firewall_re1 = {
    name               = "default_to_firewall_re1"
    resource_group_key = "aks_spoke_re1"
  }
}

azurerm_routes = {

  default_to_firewall_re1 = {
    name               = "0-0-0-0-through-firewall-re1"
    resource_group_key = "aks_spoke_re1"
    route_table_key    = "default_to_firewall_re1"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "VirtualAppliance"
    next_hop_type_key  = "azurerm_firewall"
    lz_key             = "networking_hub"

    # To be set when next_hop_type = "VirtualAppliance"
    private_ip_keys = {
      azurerm_firewall = {
        key             = "fw_re1"
        interface_index = 0
      }
      # virtual_machine = {
      #   key = ""
      #   nic_key = ""
      # }
    }
  }
}
