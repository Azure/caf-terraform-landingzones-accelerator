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

data "flux_install" "main" {
  target_path = var.target_install_path
}

data "flux_sync" "main" {
  target_path = var.target_sync_path
  url         = "https://github.com/${var.github_owner}/${var.repository_name}.git"
  branch      = var.branch   
  secret      = var.flux_auth_secret
}

# Kubernetes
resource "kubernetes_namespace" "flux-system" {
  count = var.flux_namespace == "" ? 0 : 1 
  metadata {
    name = var.flux_namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

resource "kubernetes_secret" "fluxauth" {
  count = var.flux_namespace == "" ? 0 : 1
  metadata {
    name = var.flux_auth_secret
    namespace = var.flux_namespace
  }
  data = {
    username = var.github_owner
    password = var.github_token
  }

  type = "kubernetes.io/basic-auth"
}


