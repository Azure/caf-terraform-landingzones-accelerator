# AKS cluster to deploy the helm charts runners
aks_cluster_key      = "cluster_re1"
aks_cluster_vnet_key = "vnet_gitops"

aks_clusters = {
  cluster_re1 = {
    lz_key = "caf_gitops_aks"
    key    = "cluster_re1"
  }
}

managed_identities = {
  azdoaksmsipat = {
    lz_key = "caf_gitops_aks"
    msi_keys = [
      "azdoaksmsipat"
    ]
  }
  launchpad_msi = {
    lz_key = "launchpad"
    msi_keys = [
      "level0",
      "level1",
      "level2",
      "level3",
      "level4"
    ]
  }

}

aad_pod_identity = {
  namespace     = "caf-gitops-runners"
  yaml_template = "aad-msi-binding.yaml"
}