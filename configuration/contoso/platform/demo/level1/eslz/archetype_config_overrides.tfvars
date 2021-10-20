archetype_config_overrides = {

  root = {
    archetype_id = "root"
    parameters = {
      "Deny-Resource-Locations" = {
        "listOfAllowedLocations" = {
          value = [
            "southeastasia",
            "eastasia"
          ]
        }
      }
      "Deny-RSG-Locations" = {
        "listOfAllowedLocations" = {
          value = [
            "southeastasia",
            "eastasia"
          ]
        }
      }
      "Deploy-Resource-Diag" = {
        "logAnalytics" = {
          lz_key        = "management"
          output_key    = "diagnostics"
          resource_type = "log_analytics"
          resource_key  = "central_logs_region1"
          attribute_key = "id"
        }
        "profileName" = {
          value = "eslz-diagnostic-log"
        }
      }
      "Deploy-VM-Monitoring" = {
        "logAnalytics_1" = {
          lz_key        = "management"
          output_key    = "diagnostics"
          resource_type = "log_analytics"
          resource_key  = "central_logs_region1"
          attribute_key = "id"
        }
      }
      "Deploy-VMSS-Monitoring" = {
        "logAnalytics_1" = {
          lz_key        = "management"
          output_key    = "diagnostics"
          resource_type = "log_analytics"
          resource_key  = "central_logs_region1"
          attribute_key = "id"
        }
      }
    }
    access_control = {}
  } //root

  landing-zones = {
    archetype_id   = "landingzone"
    parameters     = {}
    access_control = {}
  }

  platform = {
    archetype_id   = "platform"
    parameters     = {}
    access_control = {}
  }

  connectivity = {
    archetype_id   = "platform_connectivity"
    parameters     = {}
    access_control = {}
  }

  identity = {
    archetype_id   = "platform_identity"
    parameters     = {}
    access_control = {}
  }

  management = {
    archetype_id   = "platform_management"
    parameters     = {}
    access_control = {}
  }

  decommissioned = {
    archetype_id   = "es_decommissioned"
    parameters     = {}
    access_control = {}
  }

  sandboxes = {
    archetype_id   = "es_sandboxes"
    parameters     = {}
    access_control = {}
  }
}
