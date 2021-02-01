
app_service_plans = {
  # asp1 = {
  #   app_service_environment_key = "ase1"
  #   resource_group_key          = "asp_region1"

  #   name = "ase1-asp01"
  #   kind = "Windows"

  #   sku = {
  #     tier             = "Isolated"
  #     size             = "I1"
  #     capacity         = "1"
  #     per_site_scaling = true
  #   }
  # },
  asp2 = {
    app_service_environment_key = "ase1"
    resource_group_key          = "asp_region1"

    name = "ase1-asp02"
    kind = "Linux"

    //When creating a Linux App Service Plan, the reserved field must be set to true
    reserved = true

    sku = {
      tier             = "Isolated"
      size             = "I1"
      capacity         = "1"
      per_site_scaling = true
    }
  }
}