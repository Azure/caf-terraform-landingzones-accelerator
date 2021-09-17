
### Platform subscriptions
Set-up the subscription delegations for platform and landingzone subscriptions

```bash
# For manual bootstrap:
# Login to the subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_name }} with the user {{ config.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_platform.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -tfstate {{ tfstates.platform_subscriptions.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan

```


# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

[Deploy the management services](../../level1/management/readme.md)