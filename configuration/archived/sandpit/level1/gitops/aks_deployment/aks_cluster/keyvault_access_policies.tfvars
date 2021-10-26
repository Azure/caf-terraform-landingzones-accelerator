# Review the service principals which needs access to this
keyvault_access_policies = {
  secrets = {
    azdoaksmsipat = {
      keyvault_lz_key      = "launchpad"
      managed_identity_key = "azdoaksmsipat"
      secret_permissions   = ["Get"]
    }
  }
}