aks_clusters = {
  cluster_re1 = {
    name               = "akscluster-re1-001"
    resource_group_key = "aks_re1"
    os_type            = "Linux"

    diagnostic_profiles = {
      operations = {
        name             = "aksoperations"
        definition_key   = "azure_kubernetes_cluster"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    identity = {
      type = "SystemAssigned"
    }


    # kubernetes_version = "1.20.5"
    vnet_key = "vnet_aks_re1"

    # network plugin and network policy should be "azure" (recommended by Secure AKS baseline)
    network_profile = {
      network_plugin    = "azure"
      load_balancer_sku = "Standard"
      outbound_type     = "userDefinedRouting"
    }

    # until the issue with Flux and Azure policy is resolved https://github.com/fluxcd/flux2/issues/703
    #network_policy = "azure"

    role_based_access_control = {
      enabled = true
      azure_active_directory = {
        managed = true
        # admin_group_object_names = ["aks-cluster-re1-admins"]
        admin_group_object_ids = ["7304e4e7-b148-4ada-a135-6049c702d21e"]
        # azuread_groups = {
        #   keys = ["aks_cluster_re1_admins"]
        # }
      }
    }
    
    sku_tier = "Paid"

    addon_profile = {
      oms_agent = {
        enabled           = true
        log_analytics_key = "central_logs_region1"
      }
      azure_policy = {
        enabled = true
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
      vm_size               = "Standard_DS2_v2"
      subnet_key            = "aks_nodepool_system"
      enabled_auto_scaling  = false
      enable_node_public_ip = false
      max_pods              = 30
      node_count            = 3
      os_disk_type          = "Ephemeral"
      os_disk_size_gb       = 80
      # orchestrator_version  = "1.20.5"
      tags = {
        "project" = "system services"
      }
    }

    node_resource_group_name = "aks-nodes-re1"

    node_pools = {
      pool1 = {
        name                = "npuser01"
        mode                = "User"
        subnet_key          = "aks_nodepool_user1"
        max_pods            = 30
        vm_size             = "Standard_DS3_v2"
        node_count          = 3
        os_disk_type        = "Ephemeral"
        enable_auto_scaling = false
        os_disk_size_gb     = 120
        # orchestrator_version = "1.20.5"
        tags = {
          "project" = "user services"
        }
      }
    }

  }
}
