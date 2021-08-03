aks_cluster_key = "cluster_re1"
aks_cluster_vnet_key = "vnet_aks_re1"

aks_clusters = {
  cluster_re1 = {
    lz_key = "aks"
    key    = "cluster_re1"
  }
}
vnets = {
  vnet_aks_re1 = {
    lz_key = "networking_spoke"
    key    = "vnet_aks_re1"
    # subnet_keys = [
    #   "aks_nodepool_user1",
    #   "aks_ingress"
    # ]
  }
}
#
# Reference to the AAD managed identities to register to the AKS cluster
#
managed_identities = {
  ingress_msi = {
    lz_key = "aks"
    msi_keys = [
      "ingress",
    ]
  }
}
namespaces = {
  flux = {
    name = "flux-system"
  }
}

flux_settings = {
  aks_secure_baseline = {
    namespace = "flux-system"
    url = "https://github.com/Azure/caf-terraform-landingzones-starter.git"
    branch = "starter"
    target_path = "./enterprise_scale/construction_sets/aks/online/aks_secure_baseline/cluster-baseline-settings"
  }
}
