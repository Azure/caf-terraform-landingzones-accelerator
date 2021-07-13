azuread_groups = {
  caf_launchpad_maintainer = {
    name                   = "caf-launchpad-maintainers-rw"
    description            = "High privileged group to run all CAF deployments from vscode. Can be used to bootstrap or troubleshoot deployments."
    prevent_duplicate_name = true
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

  level3_cs_deployer = {
    name                   = "caf-level3-cs-deployer"
    prevent_duplicate_name = true
    members = {
      azuread_service_principal_keys = ["level3_cs_deployer"]
    }
  }

}
