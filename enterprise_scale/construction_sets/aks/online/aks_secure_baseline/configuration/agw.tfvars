application_gateways = {
  agw1_az1 = {
    resource_group_key = "agw_re1"
    name               = "app_gateway"
    vnet_key           = "vnet_aks_re1"
    subnet_key         = "application_gateway"
    sku_name           = "WAF_v2"
    sku_tier           = "WAF_v2"
    capacity = {
      autoscale = {
        minimum_scale_unit = 0
        maximum_scale_unit = 10
      }
    }
    zones        = ["1"]
    enable_http2 = true

    identity = {
      managed_identity_keys = [
        "apgw_keyvault_secrets"
      ]
    }

    front_end_ip_configurations = {
      public = {
        name          = "public"
        public_ip_key = "agw_pip1_re1"
        subnet_key    = "application_gateway"
      }
      private = {
        name                          = "private"
        vnet_key                      = "vnet_aks_re1"
        subnet_key                    = "application_gateway"
        subnet_cidr_index             = 0 # It is possible to have more than one cidr block per subnet
        private_ip_offset             = 4 # e.g. cidrhost(10.10.0.0/25,4) = 10.10.0.4 => AGW private IP address
        private_ip_address_allocation = "Static"
      }
    }

    front_end_ports = {
      80 = {
        name     = "http-80"
        port     = 80
        protocol = "Http"
      }
      443 = {
        name     = "https-443"
        port     = 443
        protocol = "Https"
      }
    }

    trusted_root_certificate = {
      wildcard_ingress = {
        name = "wildcard-ingress"
        # data = 
        keyvault_key = "secrets"
      }
    }
  }
}