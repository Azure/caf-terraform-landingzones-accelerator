
landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "ase"
  tfstates = {
    # networking_spoke_ase = {
    #   level   = "current"
    #   tfstate = "networking_spoke_ase.tfstate"
    # }
    shared_services = {
      level   = "lower"
      tfstate = "caf_shared_services.tfstate"
    }
  }
}

resource_groups = {
  ase_region1 = {
    name   = "ase"
    region = "region1"
  }
  asp_region1 = {
    name   = "asp"
    region = "region1"
  }
  networking_ase = {
    name   = "networking-ase"
    region = "region1"
  }
}


# diagnostics_definition = {
#   ase = {
#     name = "operational_logs_and_metrics"
#     categories = {
#       log = [
#         # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#         ["AppServiceEnvironmentPlatformLogs", true, true, 5],
#       ]
#       # metric = [
#       #   #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#       #   ["AllMetrics", false, false, 7],
#       # ]
#     }
#   }

# }