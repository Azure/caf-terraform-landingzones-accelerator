
### Deploy base resources in {{ asvm_folder }}

```bash
rover login -t {{ config_platform.platform_identity.tenant_name }}.onmicrosoft.com

unset ARM_SKIP_PROVIDER_REGISTRATION

cd /tf/caf/landingzones
git pull
git checkout {{ asvm_resources.gitops.landingzones }}

rover \
{% if config_platform.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ config_asvm.configuration_folders[base_folder_asvm].destination_base_path }}/{{ config_asvm.configuration_folders[base_folder_asvm].destination_relative_path }}/{{ level }}/{{ asvm_folder }}/resources \
  -tfstate_subscription_id {{ config_platform.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -target_subscription {{ asvm_subscriptions_details[asvm_folder].subscription_id }} \
  -tfstate {{ tfstates_asvm[asvm_folder].resources.tfstate }} \
  --workspace {{ tfstates_asvm[asvm_folder].workspace }} \
  -log-severity {{ config_platform.gitops.rover_log_error }} \
  -env {{ config_platform.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstates_asvm[asvm_folder].resources.tfstate }}.tfplan \
  -a plan

rover logout

```


# Next steps


 [Deploy the vnet connection to the virtual hub](../vhub_connection/readme.md)