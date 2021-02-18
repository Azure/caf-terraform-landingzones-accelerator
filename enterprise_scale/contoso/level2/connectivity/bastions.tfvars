# bastion_hosts = {
#   bastion_hub_connectivity = {
#     name               = "bastion-re1"
#     region             = "region1"
#     resource_group_key = "contoso_bastion"
#     vnet_key           = "connectivity_bastion"
#     subnet_key         = "AzureBastionSubnet"
#     public_ip_key      = "bastion_host_re1"

#     # you can setup up to 5 profiles
#     diagnostic_profiles = {
#       operations = {
#         definition_key   = "bastion_host"
#         destination_type = "log_analytics"
#         destination_key  = "central_logs"
#       }
#     }
#   }
# }