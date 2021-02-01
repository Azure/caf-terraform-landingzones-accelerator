
keyvaults = {
  ssh = {
    name                = "sshl2"
    resource_group_key  = "rg1"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level0_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level0_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      msi_level0 = {
        lz_key               = "launchpad"
        managed_identity_key = "level0"
        secret_permissions   = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      # Uncomment if run locally, not needed in pipelines deployment.
      # logged_in_user = {
      #   # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
      #   # More examples in /examples/keyvault
      #   secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      # }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}