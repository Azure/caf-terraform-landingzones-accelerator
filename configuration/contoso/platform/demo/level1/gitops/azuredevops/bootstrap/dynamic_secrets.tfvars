
# Store output attributes into keyvault secret
# Those values are used by the rover to connect the current remote state and
# identity the lower level
dynamic_keyvault_secrets = {
  azuredevops = {
    admin = {
      secret_name = "azdo-pat-admin"
      value       = ""
    }
    agent = {
      secret_name = "azdo-pat-agent"
      value       = ""
    }
  }
}