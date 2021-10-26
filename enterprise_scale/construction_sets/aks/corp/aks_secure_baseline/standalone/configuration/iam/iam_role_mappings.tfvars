#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {

  built_in_role_mapping = {
    keyvaults = {
      secrets = {
        "Contributor" = {
          managed_identities = {
            keys = ["ingress"]
          }
        } // "Contributor"
      }   // logged_in_subscription
    }     // subscriptions
    managed_identities = {
      aks_control_plane = {
        "Managed Identity Operator" = {
          managed_identities = {
            keys = ["aks_kubelet"]
          }
        }
      }
    }
    # aks_clusters = {
    #   cluster_re1 = {
    #     "Azure Kubernetes Service Cluster Admin Role" = {
    #       # azuread_groups = {
    #       #   keys = ["aks_admins"]
    #       # }
    #       logged_in = {
    #         keys = ["user"]
    #       }
    #       managed_identities = {
    #         keys = ["jumpbox"]
    #       }
    #     }
    #   }
    # }
    azure_container_registries = {
      acr1 = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
  }       // built_in_role_mapping
}         // role_mapping

