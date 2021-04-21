provider "flux" {}

provider "kubectl" {
 host                   = data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.host
 client_key             = base64decode(data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.cluster_ca_certificate)
 client_certificate     = base64decode(data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.client_key)
 cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.cluster_ca_certificate)
}

provider "kubernetes" {
 host                   = data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.host
 client_key             = base64decode(data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.cluster_ca_certificate)
 client_certificate     = base64decode(data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.client_key)
 cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.kubeconfig["cluster_re1"].kube_admin_config.0.cluster_ca_certificate)
}

# Get kubeconfig from AKS clusters
data "azurerm_kubernetes_cluster" "kubeconfig" {
  for_each = var.aks_clusters

  name                = module.caf.aks_clusters.cluster_re1.cluster_name
  resource_group_name = module.caf.aks_clusters.cluster_re1.resource_group_name
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

resource "kubectl_manifest" "install" {
  for_each   = var.flux_namespace == "" ? {} : { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux-system]
  yaml_body  = each.value
}

resource "kubectl_manifest" "sync" {
  for_each   = var.flux_namespace == "" ? {} : { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux-system]
  yaml_body  = each.value
}

