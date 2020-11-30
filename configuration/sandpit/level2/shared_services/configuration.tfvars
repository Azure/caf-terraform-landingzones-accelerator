landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "foundations"
  level               = "level2"
  key                 = "shared_services"
  tfstates = {
    foundations = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
    launchpad = {
      level   = "lower"
      tfstate = "caf_foundations.tfstate"
    }
  }
}

resource_groups = {
  primary = {
    name = "sharedsvc_re1"
  }
}

recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"

    region = "region1"

    diagnostic_profiles = {
      asr1 = {
        definition_key   = "azure_site_recovery"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    backup_policies = {
      vms = {
        policy1 = {
          name      = "VMBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          backup = {
            frequency = "Daily"
            time      = "23:00"
            #if not desired daily, can pick weekdays as below:
            #weekdays  = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
          }
          retention_daily = {
            count = 10
          }
          retention_weekly = {
            count    = 42
            weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
          }
          retention_monthly = {
            count    = 7
            weekdays = ["Sunday", "Wednesday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 77
            weekdays = ["Sunday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
      }
    }
  }

}

automations = {
  auto1 = {
    name               = "autore1"
    resource_group_key = "primary"

    region = "region1"

    diagnostic_profiles = {
      auto1 = {
        definition_key   = "azure_automation"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}