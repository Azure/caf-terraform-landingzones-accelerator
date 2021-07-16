
### Management
Deploy the management services

```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.tenant_name }}.onmicrosoft.com

export ARM_USE_AZUREAD=true
caf_env="{{ config.launchpad.caf_environment }}"

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ config.destination_install_path }}{{ config.destination_relative_base_path }}/{{ level }}/{{ base_folder }} \
  -tfstate {{ tfstates.management.tfstate }} \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan

rover logout

```
