# Create Azure AD users.
# If you do not have permissions in the Azure Active Directory tenant, this variable can be commented
# azuread_users = {

#   # don't change that key
#   aad-user-aks-breakglass-user-admin = {

#     # When set to true, the user will be added the CAF prefix.
#     # It can help with testing scenarios to indentify related resources
#     useprefix               = true
#     user_name               = "aks-breakglass-user"
#     password_expire_in_days = 180

#     # Value must match with var.keyvaults[keyname] to store username and password for password rotation
#     keyvault_key = "secrets"
#   }

# }


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

# azuread_apps = {

#   # Create an Azure Active Directory Application for Github workflows
#   github-workflow-aks-cluster = {
#     useprefix               = true
#     application_name        = "github-workflow-aks-cluster"
#     password_expire_in_days = 180

#     # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
#     # Set the policy during the creation process of the launchpad
#     keyvaults = {
#       secrets = {
#         secret_prefix = "aadapp-github-workflow-aks-cluster"
#       }
#     }
#   }

# }