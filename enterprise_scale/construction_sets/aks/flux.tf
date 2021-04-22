
 module "flux" {
  source = "./add-ons/flux"

  cluster_key = "cluster_re1"

  aks_clusters = module.caf.aks_clusters

  flux_namespace = var.flux_namespace

  flux_auth_secret = var.flux_auth_secret

  github_owner = var.github_owner

  github_token = var.github_token

  repository_name = var.repository_name

  repository_visibility = var.repository_visibility

  branch = var.branch

  target_install_path = var.target_install_path

  target_sync_path = var.target_sync_path

}
