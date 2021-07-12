provider "azurerm" {
  features {
  }
}

provider "kubectl" {
  host                   = try(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.host, null)
  username               = try(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.username, null)
  password               = try(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.password, null)
  client_key             = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.client_key), null)
  client_certificate     = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.client_certificate), null)
  cluster_ca_certificate = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.cluster_ca_certificate), null)
  load_config_file       = false
}

provider "kubernetes" {
  host                   = try(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.host, null)
  username               = try(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.username, null)
  password               = try(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.password, null)
  client_key             = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.client_key), null)
  client_certificate     = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.client_certificate), null)
  cluster_ca_certificate = try(base64decode(data.azurerm_kubernetes_cluster.kubeconfig.kube_admin_config.0.cluster_ca_certificate), null)
}

# Get kubeconfig from AKS clusters
data "azurerm_kubernetes_cluster" "kubeconfig" {
  name                = var.aks_clusters[var.aks_cluster_key].cluster_name
  resource_group_name = var.aks_clusters[var.aks_cluster_key].resource_group_name
}