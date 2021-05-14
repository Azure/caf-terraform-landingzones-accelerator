keyvault_certificate_requests = {

  wildcard_ingress = {
    name         = "wildcard-ingress"
    keyvault_key = "secrets"
    certificate_policy = {
      issuer_key_or_name  = "self"
      exportable          = true
      key_size            = 4096 // value can be 2048, 3072 or 4096
      key_type            = "RSA"
      reuse_key           = false
      renewal_action      = "EmailContacts"
      lifetime_percentage = 90
      # days_before_expiry  = 10
      content_type = "application/x-pkcs12" // application/x-pem-file

      x509_certificate_properties = {

        # Refer to the documentation step to adjust the public dns domain name setup in internet_domain_name.tfvars
        subject            = "CN=*.aks-ingress.contoso.com"
        validity_in_months = 12
        key_usage          = ["keyCertSign"]
        subject_alternative_names = {
          dns_names = []
          emails    = []
          upns      = []
        }
      }
    }
  }
  appgateway = {
    name         = "appgateway"
    keyvault_key = "secrets"
    certificate_policy = {
      issuer_key_or_name  = "self"
      exportable          = true
      key_size            = 4096 // value can be 2048, 3072 or 4096
      key_type            = "RSA"
      reuse_key           = false
      renewal_action      = "EmailContacts"
      lifetime_percentage = 90
      # days_before_expiry  = 10
      content_type = "application/x-pkcs12" // application/x-pem-file

      x509_certificate_properties = {

        # Refer to the documentation step to adjust the public dns domain name setup in internet_domain_name.tfvars
        # subject            = "CN=*.aks-ingress.contoso.com"
        domain_name_registration = {
          # lz_key = ""
          key = "random_domain"
          # subdomain = "*"
        }
        validity_in_months = 12
        key_usage          = ["keyCertSign"]
        subject_alternative_names = {
          dns_names = []
          emails    = []
          upns      = []
        }
      }
    }
  }
}
