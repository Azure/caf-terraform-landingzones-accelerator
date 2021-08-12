monitoring = {
  service_health_alerts = {
    enable_service_health_alerts = true
    name                         = "alerts"
    action_group_name            = "actiongrp"
    shortname                    = "HealthAlerts"
    resource_group_key           = "mgmt"

    email_alert_settings = {
      email1 = {
        name                    = "email_alert_support1"
        email_address           = "sergio.mym@gmail.com"
        use_common_alert_schema = false
      }
    } #add more email alerts by repeating the block.
    # webhook = {
    #   teams = {
    #     name        = "servicehealth"
    #     service_uri = ""
    #   }
    # }
  }
}
