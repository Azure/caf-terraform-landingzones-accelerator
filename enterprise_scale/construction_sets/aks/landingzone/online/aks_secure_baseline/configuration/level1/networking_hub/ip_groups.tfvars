ip_groups = {
  aks_ip_group1 = {
    name               = "aks_ip_group1"
    cidrs              = ["10.100.80.0/22"] # if cidrs is defined all vnet & subnet are ignored
    resource_group_key = "vnet_hub_re1"
    # vnet_key = "vnet_aks_re1"
    # subnet_keys = ["aks_nodepool_system","aks_nodepool_user1"]  # can be either unclared or empty, will take vnet cidr instead
  }
}
