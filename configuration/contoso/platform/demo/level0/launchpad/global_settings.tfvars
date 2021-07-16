# naming convention settings
# for more settings on naming convention, please refer to the provider documentation: https://github.com/aztfmod/terraform-provider-azurecaf
#
# passthrough means the default CAF naming convention is not applied and you are responsible
# of the unicity of the names you are giving. the CAF provider will clear out
passthrough = false
# adds random chars at the end of the names produced by the provider
# Do not change the following values once the launchpad deployed.

# Enable tag inheritance (can be changed)
inherit_tags = false
# When passthrough is set to false, define the number of random characters to add to the names
random_length = 5

# Default region. When not set to a resource it will use that value
default_region_key = "region1"

# You can reference the regions by using region1, region2 or set your own keys
regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

# Rover will adjust some tags to enable the discovery of the launchpad.
launchpad_key_names = {
  keyvault = "level0"
  tfstates = [
    "level0",
    "level1",
    "level2",
    "level3"
  ]
}

# Global tags
tags = {
  ApplicationOwner = "sre"
  BusinessUnit     = "sre"
}