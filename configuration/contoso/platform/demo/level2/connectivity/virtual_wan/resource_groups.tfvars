resource_groups = {
  contoso_global_wan = {
    name   = "contoso-connectivity-global-wan"
    region = "region1"
  }
  egress_fw_region1 = {
    name   = "contoso-connectivity-global-wan"
    region = "region1"
  }
  contoso_global_dns = {
    name   = "contoso-connectivity-global-dns"
    region = "region1"
  }
  #   contoso_er_circuits = {
  #     name   = "contoso-connectivity-er-circuits"
  #     region = "{'name': 'southeastasia', 'slug': 'sea'}"
  #   }

}