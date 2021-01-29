aks_clusters = {
  cluster_re1 = {
    name               = "akscluster-re1-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"

    identity = {
      type = "SystemAssigned"
    }

    kubernetes_version = "1.19.6"
    vnet_key           = "vnet_aks_re1"

    network_profile = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
    }

    role_based_access_control = {
      enabled = true
      azure_active_directory = {
        managed = true
      }
    }

    addon_profile = {
      oms_agent = {
        enabled = true
        log_analytics_key = "central_logs_region1"
      }
      azure_policy = {
        enabled = true
      }
    }

    admin_groups = {
      # ids = []
      azuread_groups = {
        keys = ["aks_cluster_re1_admins"]
      }
    }

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
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 1
      os_disk_size_gb       = 512
      orchestrator_version  = "1.19.6"
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

    node_pools = {
      pool1 = {
        name                 = "npuser01"
        mode                 = "User"
        subnet_key           = "aks_nodepool_user1"
        max_pods             = 30
        vm_size              = "Standard_F4s_v2"
        node_count           = 3
        enable_auto_scaling  = false
        os_disk_size_gb      = 512
        orchestrator_version = "1.19.6"
        tags = {
          "project" = "user services"
        }
      }
    }

  }
}