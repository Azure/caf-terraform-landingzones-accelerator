
# Firewall Policy


```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.tenant_name }}.onmicrosoft.com

cd {{ config.configuration_folders.platform.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.caf_landingzone_branch }}

export ARM_USE_AZUREAD=true
caf_env="{{ config.caf_terraform.launchpad.caf_environment }}"

rover \
  -lz {{ config.configuration_folders.platform.destination_base_path }}landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }}/firewall_policies/{{ firewall_policy }} \
  -tfstate {{ tfstates.firewall_policies[firewall_policy].tfstate }} \
  -log-severity ERROR \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan


```
