diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "ops_re1"
  }
}

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }
}