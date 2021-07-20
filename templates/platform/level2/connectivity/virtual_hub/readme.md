
# Virtual hub
Deploy networking services

```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.tenant_name }}.onmicrosoft.com

cd {{ config.destination_install_path }}landingzones
git fetch origin
git checkout {{ config.caf_landingzone_branch }}

export ARM_USE_AZUREAD=true
caf_env="{{ config.launchpad.caf_environment }}"

rover \
  -lz {{ config.destination_install_path }}landingzones/caf_solution \
  -var-folder {{ config.destination_install_path }}{{ config.destination_relative_base_path }}/{{ level }}/{{ base_folder }}/virtual_hubs/{{ virtual_hub }} \
  -tfstate {{ tfstates.virtual_hubs[virtual_hub].tfstate }} \
  -log-severity ERROR \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan


```
