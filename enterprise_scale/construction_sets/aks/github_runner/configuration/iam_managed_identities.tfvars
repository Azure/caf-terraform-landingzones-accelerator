managed_identities = {
  ingress = {
    name               = "podmi-github-runner"
    resource_group_key = "devops_re1"
  }
  apgw_keyvault_secrets = {
    name               = "agw-secrets-msi"
    resource_group_key = "devops_re1"
  }
}