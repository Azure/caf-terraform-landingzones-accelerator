# ## need to add gateway, gateway connection, authorization key, etc.
# express_route_circuits = {
#   er1 = {
#     name                  = "errg1"
#     resource_group_key    = "contoso_er_circuits"
#     service_provider_name = "Equinix"
#     peering_location      = "Singapore"
#     tier                  = "Standard"
#     bandwidth_in_mbps     = 50
#   }
# }
# virtual_hub_er_gateway_connections = {
#   er1-con = {
#     virtual_hub = {
#       key = "hub_re1"
#     }
#     express_route_circuit = {
#       key = "er1"
#     }
#     region = "region1"
#     resource_group_key    = "contoso_er_circuits"
#   }
# }