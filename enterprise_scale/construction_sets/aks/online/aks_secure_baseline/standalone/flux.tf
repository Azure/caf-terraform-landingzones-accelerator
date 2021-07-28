module "flux_addon" {
  source          = "./add-ons/flux"
  flux_settings   = var.flux_settings
  aks_clusters    = module.caf.aks_clusters
  aks_cluster_key = var.aks_cluster_key
}
