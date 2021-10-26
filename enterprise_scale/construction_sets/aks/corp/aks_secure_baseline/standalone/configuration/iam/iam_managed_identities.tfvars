managed_identities = {
  ingress = {
    name               = "podmi-ingress-controller"
    resource_group_key = "devops_re1"
  }
  apgw_keyvault_secrets = {
    name               = "agw-secrets-mi"
    resource_group_key = "devops_re1"
  }
  aks_control_plane = {
    name               = "aks-control-mi"
    resource_group_key = "devops_re1"
  }
  aks_kubelet = {
    name               = "aks_kubelet"
    resource_group_key = "devops_re1"
  }
}