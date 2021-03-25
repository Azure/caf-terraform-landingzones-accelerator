locals {
  security = {
    keyvault_certificate_issuers  = var.keyvault_certificate_issuers
    keyvault_certificate_requests = var.keyvault_certificate_requests
    keyvault_certificates         = var.keyvault_certificates
    keyvault_keys                 = var.keyvault_keys
  }
}