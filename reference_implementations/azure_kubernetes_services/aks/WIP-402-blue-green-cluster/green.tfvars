tags       = {}
convention = "cafrandom"
clusters = {
  seacluster = {
    name                = "seacluster-green"
    location            = "southeastasia"
    resource_group_name = "aks-green"
    os_type             = "Linux"
    identity = {
      type = "SystemAssigned"
    }
    kubernetes_version = "1.15.12"
    vnet_key           = "spoke_aks_sg"
    network_policy = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"

    }
    enable_rbac = true

    load_balancer_profile = {
      # Only one option can be set
      managed_outbound_ip_count = 1
      # outbound_ip_prefix_ids = []
      # outbound_ip_address_ids = []
    }

    default_node_pool = {
      name                  = "sharedsvc"
      vm_size               = "Standard_F4s_v2"
      subnet_key            = "aks_nodepool_system"
      availability_zones    = ["1"]
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 1
      os_disk_size_gb       = 64
      orchestrator_version  = "1.15.11"
      tags = {
        "project" = "shared services"
      }
    }

    node_pools = {

      pool1 = {
        name                 = "nodepool1"
        mode                 = "System"
        subnet_key           = "aks_nodepool_system1"
        max_pods             = 30
        vm_size              = "Standard_DS2_v2"
        node_count           = 3
        enable_auto_scaling  = false
        os_disk_size_gb      = 64
        orchestrator_version = "1.15.11"
      }
      pool2 = {
        name                 = "nodepool2"
        mode                 = "User"
        subnet_key           = "aks_nodepool_user1"
        max_pods             = 10
        vm_size              = "Standard_DS2_v2"
        node_count           = 1
        enable_auto_scaling  = false
        availability_zones   = ["1"]
        os_disk_size_gb      = 64
        orchestrator_version = "1.15.11"
      }
    }
  }
}