# Enterprise scale

## Deploy Enterprise Scale

Note you need to adjust the branch to deploy Enterprise Scale to {{ config.platform_core_setup.enterprise_scale.private_lib[config.platform_core_setup.enterprise_scale.private_lib.version_to_deploy].caf_landingzone_branch }}

```bash
az account clear
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com

cd {{ config.configuration_folders.platform.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.platform_core_setup.enterprise_scale.private_lib[config.platform_core_setup.enterprise_scale.private_lib.version_to_deploy].caf_landingzone_branch }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_eslz.vault_uri }} \
{% endif %}
  -lz {{ config.configuration_folders.platform.destination_base_path }}landingzones/caf_solution/add-ons/caf_eslz \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -tfstate {{ tfstates.eslz.tfstate }} \
  -log-severity ERROR \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan

```

# Next steps

 [Deploy Connectivity](../../level2/connectivity/readme.md)
