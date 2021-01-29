application_gateway_applications = {
  aspnetapp_az1_agw1 = {

    name                    = "aspnetapp"
    application_gateway_key = "agw1_az1"

    listeners = {
      public_ssl = {
        name                           = "aspnetapp-443-public"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "80"
        host_name                      = "aspnetapp.cafdemo.com"
        request_routing_rule_key       = "default"
        # keyvault_certificate = {
        #   certificate_key = "aspnetapp.cafdemo.com"
        # }
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
    }

    backend_pool = {
      fqdns = [
        "bu0001a0008-00.aks-ingress.contoso.com"
      ]
    }

  }
}