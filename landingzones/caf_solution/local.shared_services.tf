locals {
  shared_services = {
    automations     = var.automations
    monitoring      = var.monitoring
    recovery_vaults = var.recovery_vaults
  }
}
