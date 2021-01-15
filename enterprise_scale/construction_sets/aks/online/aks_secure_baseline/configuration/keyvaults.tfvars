
# keyvaults = {

#   # This keyvault is used to store the complex password created for the AKS breakglass admin user
#   secrets = {
#     name                = "secrets"
#     resource_group_key  = "aks_re1"
#     region              = "region1"
#     sku_name            = "premium"
#     soft_delete_enabled = true

#     creation_policies = {
#       logged_in_user = {
#         # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
#         secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
#       }
#     }


#   }
# }
