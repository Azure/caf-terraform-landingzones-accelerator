azure_container_registries = {
  acr1 = {
    name               = "caf-gitops-acr-rover" # no naming convention
    resource_group_key = "gitops"
    sku                = "Premium"
  }
}

# sudo az acr import --name xxxx.azurecr.io --source docker.io/aztfmod/rover-preview:0.15.0-2104.260258 --image rover:0.14.10-2104.0806