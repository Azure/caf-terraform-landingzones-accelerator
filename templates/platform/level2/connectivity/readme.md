
# Connectivity
You have selected the vwan networking option to build your Enteprise Scale platform. The following instructions guides you through the steps to follow.

## Select the correct branch for the landingzones code

Note you need to adjust the branch {{ config.caf_landingzone_branch }} to deploy the connectivity services

{% for folder_name in folders %}
## Virtual Wan

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
  -var-folder {{ config.destination_install_path }}{{ config.destination_relative_base_path }}/{{ level }}/{{ base_folder }}/{{ folder_name }} \
  -tfstate {{ tfstates[folder_name].tfstate }} \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan

```

{% endfor %}