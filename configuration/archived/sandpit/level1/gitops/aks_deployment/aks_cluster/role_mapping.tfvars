role_mapping = {
  built_in_role_mapping = {
    azure_container_registries = {
      acr1 = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
    networking = {
      vnet_gitops = {
        "Network Contributor" = {
          aks_clusters = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
    keyvaults = {
      secrets = {
        lz_key = "launchpad"
        
        "Key Vault Secrets User" = {
          managed_identities = {
            keys = ["azdoaksmsipat"]
          }
        }
      }
    }
  }
}
