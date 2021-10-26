# AKS cluster to deploy the helm charts runners
aks_cluster_key      = "cluster_re1"

aks_clusters = {
  cluster_re1 = {
    lz_key = "caf_gitops_aks"
    key    = "cluster_re1"
  }
}


keyvaults = { // get PAT token
  kv1 = { # k8s_secret_name = kv1-azdo-pat-admin
    lz_key = "launchpad"
    key    = "secrets"
    secret_name = "azdo-pat-admin"
  }
}

// Just run this once in each AKS cluster
helm_charts = {
  keda = {
    name             = "keda"
    repository       = "https://kedacore.github.io/charts"
    chart            = "keda"
    namespace        = "caf-gitops-runners"
    create_namespace = "true"
  },
  akv2k8s = {
    name             = "akv2k8s"
    repository       = "https://charts.spvapi.no"
    chart            = "akv2k8s"
    namespace        = "caf-gitops-runners"
    create_namespace = "true"
    sets = {
      "env_injector.authService"     = "false",
      "controller.keyVaultAuth"      = "environment",
      "controller.podLabels.aadpodidbinding" = "azdoaksmsipat",
      "env_injector.enabled" = "false"
    }
  }
}

agent_pools = {
  output_key = "agent_pools" # output key of the remote lz
  agents = {
    level0 = { # agent_pool_key
      lz_key    = "launchpad"
      msi_key   = "level0"
    }
    level1 = {
      lz_key    = "launchpad"
      msi_key   = "level1"
    }
    level2 = {
      lz_key    = "launchpad"
      msi_key   = "level2"
    }
    level3 = {
      lz_key    = "launchpad"
      msi_key   = "level3"
    }
    level4 = {
      lz_key    = "launchpad"
      msi_key   = "level4"
    }
  }
  lz_key     = "azdo_aks_sandpit_caf_configuration"
  namespace  = "caf-gitops-runners"
  image      = "aztfmod/rover-agent:1.0.0-2106.2503-azdo"
  org_url    = "https://dev.azure.com/petronasvsts"
  keyvault_key = "kv1"
  
}