output "aks_clusters_kubeconfig" {
  value = {
    for key, aks_cluster in module.caf.aks_clusters : key => {

      aks_kubeconfig_cmd       = aks_cluster.aks_kubeconfig_cmd
      aks_kubeconfig_admin_cmd = aks_cluster.aks_kubeconfig_admin_cmd
    }
  }
  sensitive = false
}
output "aks_clusters" {
  value = {
    for key, aks_cluster in module.caf.aks_clusters : key => aks_cluster
  }
  sensitive = true
}

output "managed_identities" {
  value = module.caf.managed_identities
}

output "keyvaults" {
  value = module.caf.keyvaults
}

output "domain_name_registrations" {
  value = module.caf.domain_name_registrations
}

output "vnets" {
  value     = module.caf.vnets
  sensitive = true
}

output "azurerm_firewalls" {
  value = module.caf.azurerm_firewalls
}
