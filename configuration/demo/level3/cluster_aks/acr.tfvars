azure_container_registries = {
  acr1 = {
    name               = "acr"
    resource_group_key = "aks_re1"
    sku                = "Premium"
    # georeplication_region_keys = ["region2"]

    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_container_registry"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}

