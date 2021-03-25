locals {
  compute = {
    aks_clusters               = var.aks_clusters
    availability_sets          = var.availability_sets
    azure_container_registries = var.azure_container_registries
    bastion_hosts              = var.bastion_hosts
    proximity_placement_groups = var.proximity_placement_groups
    virtual_machines           = var.virtual_machines
  }
}