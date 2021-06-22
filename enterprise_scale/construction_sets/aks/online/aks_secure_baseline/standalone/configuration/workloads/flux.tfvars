aks_cluster_key = "cluster_re1"

flux_settings = {
  aks_secure_baseline = {
    namespace = "flux-system"
    url = "https://github.com/Azure/caf-terraform-landingzones-starter.git"
    branch = "CSE-AKS-terratest"
    target_path = "./enterprise_scale/construction_sets/aks/online/aks_secure_baseline/cluster-baseline-settings"
  }
}