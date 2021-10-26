# AKS cluster to deploy the helm charts runners
aks_cluster_key      = "cluster_re1"
aks_cluster_vnet_key = "vnet_gitops"

aks_clusters = {
  cluster_re1 = {
    lz_key = "caf_gitops_aks"
    key    = "cluster_re1"
  }
}

vnets = {
  vnet_gitops = {
    lz_key = "caf_gitops_aks"
    key    = "vnet_gitops"
    # subnet_keys = [
    #   "aks_runners",
    # ]
  }
}

#
# Reference to the AAD managed identities to register to the AKS cluster
#
managed_identities = {
  azdoaksmsipat = {
    lz_key = "caf_gitops_aks"
    msi_keys = [
      "azdoaksmsipat"
    ]
  }
  level0 = {
    lz_key = "launchpad"
    msi_keys = [
      "level0"
    ]
  }
  level1 = {
    lz_key = "launchpad"
    msi_keys = [
      "level1"
    ]
  }
  level2 = {
    lz_key = "launchpad"
    msi_keys = [
      "level2"
    ]
  }
  level3 = {
    lz_key = "launchpad"
    msi_keys = [
      "level3"
    ]
  }
  level4 = {
    lz_key = "launchpad"
    msi_keys = [
      "level4"
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
    branch = "2107.0"
    target_path = "./enterprise_scale/construction_sets/aks/online/aks_secure_baseline/cluster-baseline-settings/flux"
  }
}