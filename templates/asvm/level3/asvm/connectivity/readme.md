
```bash
rover login -t {{ config_platform.platform_identity.tenant_name }}.onmicrosoft.com

rover \
{% if config_platform.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution/add-ons/cross_tenant_hub_connection \
  -var-folder {{ config_asvm.configuration_folders[base_folder_asvm].destination_base_path }}/{{ config_asvm.configuration_folders[base_folder_asvm].destination_relative_path }}/{{ level }}/{{ asvm_folder }}/connectivity \
  -tfstate_subscription_id {{ config_platform.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -target_subscription {{ asvm_subscriptions_details[asvm_folder].subscription_id }} \
  -tfstate {{ tfstates_asvm[asvm_folder].connectivity.tfstate }} \
  --workspace {{ tfstates_asvm[asvm_folder].workspace }} \
  -log-severity {{ config_platform.gitops.rover_log_error }} \
  -env {{ config_platform.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan

rover logout

```