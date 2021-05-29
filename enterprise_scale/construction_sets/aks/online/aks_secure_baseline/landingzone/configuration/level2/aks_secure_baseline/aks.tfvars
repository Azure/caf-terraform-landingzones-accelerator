aks_cluster_key = "cluster_re1"
aks_clusters = {
  cluster_re1 = {
    lz_key = "aks"
    key    = "cluster_re1"
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
    branch = "CSE-AKS-terratest"
    target_install_path = "./enterprise_scale/construction_sets/aks/online/aks_secure_baseline/cluster-baseline-settings"
    target_sync_path = "./enterprise_scale/construction_sets/aks/online/aks_secure_baseline/cluster-baseline-settings"
  }
}