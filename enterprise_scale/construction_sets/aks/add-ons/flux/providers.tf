provider "kubectl" {
 host                   = try(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.host, null)
 client_key             = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.client_key), null)
 client_certificate     = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.client_certificate), null)
 cluster_ca_certificate = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.cluster_ca_certificate), null)
}

provider "kubernetes" {
 host                   = try(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.host, null)
 client_key             = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.client_key), null)
 client_certificate     = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.client_certificate), null)
 cluster_ca_certificate = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig[var.cluster_key].kube_admin_config.0.cluster_ca_certificate), null)
}

# Get kubeconfig from AKS clusters
data "azurerm_kubernetes_cluster" "kubeconfig" {
  for_each = var.aks_clusters

  name                = var.aks_clusters[var.cluster_key].cluster_name
  resource_group_name = var.aks_clusters[var.cluster_key].resource_group_name
}

data "flux_install" "main" {
  target_path = var.target_install_path
}

data "flux_sync" "main" {    
  target_path = var.target_sync_path
  url         = "https://github.com/${var.github_owner}/${var.repository_name}.git"
  branch      = var.branch   
  secret      = var.flux_auth_secret
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

locals {   

  install = var.flux_namespace == "" ? null : [for v in data.kubectl_file_documents.install.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
  sync = var.flux_namespace == "" ? null : [for v in data.kubectl_file_documents.sync.documents : {
    data : yamldecode(v)
    content : v
    }
  ]
}
