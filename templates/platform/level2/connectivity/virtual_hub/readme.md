
# Virtual hub

Estinated time for the deployment - 20 mins

```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.tenant_name }}.onmicrosoft.com

cd {{ config.configuration_folders.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.caf_landingzone_branch }}

export ARM_USE_AZUREAD=true
caf_env="{{ config.caf_terraform.launchpad.caf_environment }}"

rover \
  -lz {{ config.configuration_folders.destination_base_path }}landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.destination_base_path }}{{ config.configuration_folders.destination_relative_path }}/{{ level }}/{{ base_folder }}/virtual_hubs/{{ virtual_hub }} \
  -tfstate {{ tfstates.virtual_hubs[virtual_hub].tfstate }} \
  -log-severity ERROR \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan


```
