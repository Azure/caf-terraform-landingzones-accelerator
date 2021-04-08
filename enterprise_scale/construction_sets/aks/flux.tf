provider "flux" {}

provider "kubectl" {}

provider "kubernetes" {
  config_path    = var.k8s_configPath
#  host                   = module.caf.aks_clusters.cluster_re1.kube_admin_config[0].host
#  client_key             = base64decode(module.caf.aks_clusters.cluster_re1.kube_admin_config[0].client_key)
#  client_certificate     = base64decode(module.caf.aks_clusters.cluster_re1.kube_admin_config[0].client_certificate)
#  cluster_ca_certificate = base64decode(module.caf.aks_clusters.cluster_re1.kube_admin_config[0].cluster_ca_certificate)  
}

#provider "github" {
#  owner = var.github_owner
#  token = var.github_token
#}

