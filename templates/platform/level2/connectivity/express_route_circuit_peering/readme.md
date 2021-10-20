
# Express Route Circuit Peerings for {{ circuit }}

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}

cd {{ config.configuration_folders.platform.destination_base_path }}/landingzones
git fetch origin
git checkout {{ connectivity_express_routes.gitops.caf_landingzone_branch }}

rover \
{% if keyvaults is defined and config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ config.configuration_folders.platform.destination_base_path }}/landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }}/express_route_circuit_peering/{{ circuit }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
{% else %}
  -target_subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
{% endif %}
  -tfstate {{ tfstates.express_route_circuit_peerings[circuit].tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstates.express_route_circuit_peerings[circuit].tfstate }}.tfplan \
  -a plan

```

