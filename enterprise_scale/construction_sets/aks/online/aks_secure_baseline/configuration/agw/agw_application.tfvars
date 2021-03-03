application_gateway_applications = {
  aspnetapp_az1_agw1 = {

    name                    = "aspnetapp"
    application_gateway_key = "agw1_az1"

    listeners = {
      public_ssl = {
        name                           = "public-443"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "443"
        # host_name                      = "www.y4plq60ubbbiop9w1dh36tlgfpxqctfj.com"
        dns_zone = {
          key = "dns_zone1"
          record_type = "a"
          record_key = "agw"
        }

        request_routing_rule_key       = "default"
        # key_vault_secret_id = ""
        # keyvault_certificate = {
        #   certificate_key = "aspnetapp.cafdemo.com"
        # }
        keyvault_certificate_request = {
          key = "appgateway"
        }
      }
    }


    request_routing_rules = {
      default = {
        rule_type = "Basic"
      }
    }

    backend_http_setting = {
      port                                = 443
      protocol                            = "Https"
      pick_host_name_from_backend_address = true
      # trusted_root_certificate_names      = ["wildcard-ingress"]
      trusted_root_certificate_names      = ["wildcard-ingress"]
    }

    

    backend_pool = {
      fqdns = [
        "bu0001a0008-00.aks-ingress.contoso.com"
      ]
    }

  }
}