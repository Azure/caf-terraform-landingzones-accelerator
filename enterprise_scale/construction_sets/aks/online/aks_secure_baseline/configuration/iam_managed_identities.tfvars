managed_identities = {
  ingress = {
    name               = "podmi-ingress-controller"
    resource_group_key = "aks_re1"
  }
  apgw_keyvault_secrets = {
    name               = "agw-secrets-msi"
    resource_group_key = "agw_re1"
  }
}