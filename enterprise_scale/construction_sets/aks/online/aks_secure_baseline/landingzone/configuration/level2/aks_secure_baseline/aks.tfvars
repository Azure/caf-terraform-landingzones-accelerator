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

helm_charts = {
  flux = {
    name       = "flux"
    repository = "https://charts.fluxcd.io"
    chart      = "flux"
    namespace  = "flux-system"
    sets = {
      "git.url" = "git@github.com:Azure/caf-terraform-landingzones-starter",
      
    }
  }
}