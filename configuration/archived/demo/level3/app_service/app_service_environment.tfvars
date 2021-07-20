
app_service_environments = {
  ase1 = {
    resource_group_key = "ase_region1"
    name               = "ase01"
    max_length         = "80"
    kind               = "ASEV2"
    zone               = "1"

    vnet_key                  = "ase_region1"
    subnet_key                = "ase1"
    internalLoadBalancingMode = "3"

    # private_dns_records = {
    #   a_records = {
    #     ase_a_record = {
    #       name            = ""
    #       ttl             = 300
    #       lz_key          = "private_dns"
    #       private_dns_key = "ase"
    #     }
    #     wilcard = {
    #       name            = "*"
    #       ttl             = 300
    #       lz_key          = "private_dns"
    #       private_dns_key = "ase"
    #     }
    #   }
    # }

    # diagnostic_profiles = {
    #   ase = {
    #     definition_key   = "ase"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }
  }
}
