
#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {

  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          azuread_apps = {
            keys = ["github-workflow-aks-cluster"]
          }
        } // "Contributor"
      }   // logged_in_subscription
    }     // subscriptions
  }       // built_in_role_mapping
}         // role_mapping
