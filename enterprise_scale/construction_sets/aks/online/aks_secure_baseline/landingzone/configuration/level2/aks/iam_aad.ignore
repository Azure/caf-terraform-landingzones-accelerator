# Create Azure Active Directory Groups
azuread_groups = {

  # cluster_re1 AKS admin group
  #
  aks_cluster_re1_admins = {
    name        = "aks-cluster-re1-admins"
    description = "Provide read and write access to the keyvault secrets / level0."
    members = {
      user_principal_names = [
        # You can add the UPN to be part of this AKS admin group
      ]
      # You can add the object IDs of existing Azure Ad groups or users
      object_ids = []
    }
    prevent_duplicate_name = false
  }
}
