ip_groups = {
  aks_ip_group1 = {
    name = "aks_ip_group1"
    # cidrs = ["1.1.1.1/10"] # if cidrs is defined all vnet & subnet are ignored
    resource_group_key = "aks_spoke_re1"
    vnet_key = "vnet_aks_re1"
    subnet_keys = ["aks_nodepool_system","aks_nodepool_user1"]  # can be either unclared or empty, will take vnet cidr instead
  }
}
