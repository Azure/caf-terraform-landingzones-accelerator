
# Create Azure Active Directory Groups
azuread_groups = {

  # cluster_re1 AKS admin group
  #
  aks_cluster_re1_admins = {
    name        = "caf-aks-cluster-re1-admins"
    description = "Provide read and write access to the AKS cluster admin"
    members = {
      object_ids = []
    }
    prevent_duplicate_name = false
  }

}

azuread_groups_membership = {
  aks_cluster_re1_admins = { # ad group key
    # lz_key = "" # lz_key for ad group
    managed_identities = {
      launchpad = {
        lz_key = "launchpad"
        keys = ["level1"]
      }
    }
  }
}