# public_ip_addresses = {
#   bastion_host_re1 = {
#     name                    = "bastion-re1-pip1"
#     region                  = "region1"
#     resource_group_key      = "contoso_bastion"
#     sku                     = "Standard"
#     allocation_method       = "Static"
#     ip_version              = "IPv4"
#     idle_timeout_in_minutes = "4"

#     # you can setup up to 5 key
#     diagnostic_profiles = {
#       bastion_host_rg1 = {
#         definition_key   = "public_ip_address"
#         destination_type = "log_analytics"
#         destination_key  = "central_logs"
#       }
#     }
#   }

# }