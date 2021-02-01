
route_tables = {
  default_internet = {
    name               = "default_internet"
    resource_group_key = "networking_ase"
  }
}

azurerm_routes = {
  internet = {
    name               = "internet"
    resource_group_key = "networking_ase"
    route_table_key    = "default_internet"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "Internet"
  }
}