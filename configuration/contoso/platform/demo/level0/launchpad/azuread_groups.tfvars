azuread_groups = {
  caf_launchpad_maintainer = {
    name                   = "caf-launchpad-maintainers-rw"
    description            = "High privileged group to run all CAF deployments from vscode. Can be used to bootstrap or troubleshoot deployments."
    prevent_duplicate_name = true
  }
  launchpad = {
    name                   = "caf-launchpad"
    prevent_duplicate_name = true
    members = {
      azuread_service_principal_keys = ["level0"]
    }
  }
  identity = {
    name                   = "caf-identity"
    prevent_duplicate_name = true
    members = {
      azuread_service_principal_keys = ["identity"]
    }
  }

  management = {
    name                   = "caf-management"
    prevent_duplicate_name = true
    members = {
      azuread_service_principal_keys = ["management"]
    }
  }

  connectivity = {
    name                   = "caf-connectivity"
    prevent_duplicate_name = true
    members = {
      azuread_service_principal_keys = ["connectivity"]
    }
  }
  grp-azure-devops = {
    name                   = "caf-azuredevops"
    prevent_duplicate_name = true
    members = {
      azuread_service_principal_keys = ["azure_devops"]
    }
  }
  
}
