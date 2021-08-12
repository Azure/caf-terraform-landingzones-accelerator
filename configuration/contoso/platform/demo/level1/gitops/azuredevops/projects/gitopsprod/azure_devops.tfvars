azure_devops = {
  url = "https://dev.azure.com/sergiomiyama0883"

  # PAT Token should be updated manually to the keyvault after running launchpad
  pats = {
    admin = {
      secret_name  = "azdo-pat-admin"
      lz_key       = "azure_devops_bootstrap"
      keyvault_key = "azuredevops"
    }
  }
}

