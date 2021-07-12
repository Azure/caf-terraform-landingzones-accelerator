azurerm_firewalls = {
  egress-fw = {
    name               = "egress-firewall"
    sku_name           = "AZFW_Hub"
    sku_tier           = "Standard"
    resource_group_key = "contoso_global_wan"
    vnet_key           = "vnet1_region1"
    virtual_hub = {
      hub_re1 = {
        virtual_wan_key = "vwan_re1"
        virtual_hub_key = "hub_re1"
        #virtual_hub_id = "Azure_resource_id"
        #lz_key = "lz_key"
        public_ip_count = 1
      }
    }
  }
}


vnets = {
  vnet1_region1 = {
    resource_group_key = "contoso_global_wan"
    vnet = {
      name          = "vwan_demo1"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" # must be named AzureFirewallSubnet
        cidr = ["10.100.100.128/25"]
      }
    }
    subnets = {
      example = {
        name = "vwan_demo"
        cidr = ["10.100.100.0/25"]
      }
    }

  }
  # vnet2_region1 = {
  #   resource_group_key = "hub_re1"
  #   vnet = {
  #     name          = "vwan_demo2"
  #     address_space = ["10.100.200.0/24"]
  #   }
  #   specialsubnets = {}
  #   subnets = {
  #     example = {
  #       name = "vwan_demo"
  #       cidr = ["10.100.200.0/29"]
  #     }
  #   }

  # }
}