
### billing_subscription_role_delegations
Set-up the subscription delegations for platform and landingzone subscriptions

```bash
# Login to the subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_name }} with the user {{ config.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}/{{ config.configuration_folders.platform.destination_relative_path }}/level0/billing_subscription_role_delegations \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -tfstate {{ tfstates.billing_subscription_role_delegations.tfstate }} \
  -target_subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -launchpad \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan

rover logout

```


# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

[Deploy the subscriptions](../../level1/subscriptions/readme.md)