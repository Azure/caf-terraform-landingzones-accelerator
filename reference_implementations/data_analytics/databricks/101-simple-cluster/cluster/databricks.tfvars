landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "networking_hub"
  level               = "level3"
  key                 = "databricks_cluster"
  tfstates = {
    databricks_workspace = {
      tfstate = "databricks_workspace.tfstate"
    }
    networking_hub = {
      level   = "lower"
      tfstate = "networking_hub.tfstate"
    }
  }
}

databricks = {
  workspace_key           = "sales_workspaces"
  lz_key                  = "databricks_workspace"
  name                    = "Sales Autoscaling"
  spark_version           = "6.6.x-scala2.11"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 20
  autoscale = {
    min_workers = 1
    max_workers = 50
  }
  spark_conf = {
    "spark.databricks.io.cache.enabled"          = true,
    "spark.databricks.io.cache.maxDiskUsage"     = "50g",
    "spark.databricks.io.cache.maxMetaDataCache" = "1g"
  }
}
