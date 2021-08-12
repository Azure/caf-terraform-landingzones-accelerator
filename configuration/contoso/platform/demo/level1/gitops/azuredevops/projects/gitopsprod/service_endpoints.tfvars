service_endpoints = {
  gitopsprod = {
    endpoint_name = "gitopsprod-platform"
    subscription = {
      name = "caf-launchpad"
      id   = "11646ce1-8081-4d30-881c-ace8cdba2390" # gitops-prod-caf
    }

    project_key = "gitopsprod"

    keyvault = {
      lz_key      = "identity-gitops-credential-rotation"
      key         = "azure_devops"
      secret_name = "sp-client-secret"
    }

    azuread_application = {
      lz_key = "identity-gitops"
      key    = "azure_devops"
    }
  }
  gitops-prod-devops = {
    endpoint_name = "gitops-prod-devops"
    subscription = {
      name = "gitops-prod-devops"
      id   = "586fba9a-c489-4c4c-b0a2-adc0b2e68086" # gitops-prod-devops
    }

    project_key = "gitopsprod"

    keyvault = {
      lz_key      = "identity-gitops-credential-rotation"
      key         = "azure_devops"
      secret_name = "sp-client-secret"
    }

    azuread_application = {
      lz_key = "identity-gitops"
      key    = "azure_devops"
    }
  }
}
