resource "azurerm_role_assignment" "kubelet_ingressmsi_miop" {
  for_each = var.aks_clusters

  scope                = module.caf.managed_identities["ingress"].id
  role_definition_name = "Managed Identity Operator"
  principal_id         = module.caf.aks_clusters[each.key].kubelet_identity[0].object_id
}

data "azurerm_resource_group" "noderg" {
  for_each = var.aks_clusters
  name     = module.caf.aks_clusters[each.key].node_resource_group
}

resource "azurerm_role_assignment" "kubelet_noderg_miop" {
  for_each = var.aks_clusters

  scope                = data.azurerm_resource_group.noderg[each.key].id
  role_definition_name = "Managed Identity Operator"
  principal_id         = module.caf.aks_clusters[each.key].kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "kubelet_noderg_vmcontrib" {
  for_each = var.aks_clusters

  scope                = data.azurerm_resource_group.noderg[each.key].id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = module.caf.aks_clusters[each.key].kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "kubelet_vnet_networkcontrib" {
  for_each = var.aks_clusters

  scope                = module.caf.vnets[var.aks_clusters[each.key].vnet_key].id
  role_definition_name = "Network Contributor"
  principal_id         = module.caf.aks_clusters[each.key].identity[0].principal_id
}
# consider to narrow to ingress & nodepoll subnets
