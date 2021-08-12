azuread_applications = {
  gitops_platform = {
    application_name            = "sp-gitops-platform"
    available_to_other_tenants  = true
    reply_urls                  = ["https://www.microsoft.com"]
  }
}

azuread_credentials = {
  gitops_platform = {
    type                          = "password"
    azuread_credential_policy_key = "default_policy"

    azuread_application = {
      key    = "gitops_platform"
    }
    keyvaults = {
      azuredevops = {
        secret_prefix = "sp"
      }
    }
  }
}

azuread_credential_policies = {
  default_policy = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    number  = true

    # Password Expiration date
    expire_in_days = 30
    rotation_key0 = {
      # Odd number
      days = 17
    }
    rotation_key1 = {
      # Even number
      days = 10
    }
  } //password_policy
}