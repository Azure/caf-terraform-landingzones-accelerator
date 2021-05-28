landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "shared_services"
  level               = "level3"
  key                 = "app_service"
  tfstates = {
    shared_services = {
      level   = "lower"
      tfstate = "shared_services.tfstate"
    }
    network_hub = {
      level   = "lower"
      tfstate = "network_hub.tfstate"
    }
  }
}

resource_groups = {
  webapp_region1 = {
    name   = "appservice_re1"
    region = "region1"
  }
}

app_service_plans = {
  asp1 = {
    resource_group_key = "webapp_region1"
    name               = "asp1"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapp_region1"
    name                 = "webapp"
    app_service_plan_key = "asp1"

    settings = {
      enabled = true

      site_config = {
        default_documents        = ["main.aspx"]
        always_on                = true
        dotnet_framework_version = "v4.0"
      }
    }

    slots = {
      smoke_test = {
        name = "smoke-test"
      }
      ab_test = {
        name = "AB-testing"
      }
    }

    tags = {
      example = "simple_webapp"
    }
  }
}
