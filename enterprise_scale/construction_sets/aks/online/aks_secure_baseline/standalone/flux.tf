module "flux_addon" {
  source = "github.com/Azure/caf-terraform-landingzones?ref=azure_devops_v1//caf_solution/add-ons/aks_secure_baseline_v2/flux"
  for_each = var.flux_settings
  setting = each.value
  depends_on = [module.caf]
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
  name                = module.caf.aks_clusters[var.aks_cluster_key].cluster_name
  resource_group_name = module.caf.aks_clusters[var.aks_cluster_key].resource_group_name
}

output "flux_addon" {
  value = module.caf.aks_clusters[var.aks_cluster_key]
}
# module "flux" {
#   source = "./add-ons/flux"

#   cluster_key = "cluster_re1"

#   aks_clusters = module.caf.aks_clusters

#   flux_namespace = var.flux_namespace

#   flux_auth_secret = var.flux_auth_secret

#   github_owner = var.github_owner

#   github_token = var.github_token

#   repository_name = var.repository_name

#   repository_visibility = var.repository_visibility


#   branch = var.branch

#   target_install_path = var.target_install_path

#   target_sync_path = var.target_sync_path

# }
