
# Connectivity
You have selected the vwan networking option to build your Enteprise Scale platform. The following instructions guides you through the steps to follow.

## Select the correct branch for the landingzones code

Note you need to adjust the branch {{ config.gitops.caf_landingzone_branch }} to deploy the connectivity services

{% for folder_name in folders %}
## Virtual Wan

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com

cd {{ config.configuration_folders.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.gitops.caf_landingzone_branch }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ config.configuration_folders.destination_base_path }}landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.destination_base_path }}{{ config.configuration_folders.destination_relative_path }}/{{ level }}/{{ base_folder }}/{{ folder_name }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
  -tfstate {{ tfstates[folder_name].tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan

```
{% endfor %}

## Virtual hubs

{% for virtual_hub in tfstates.virtual_hubs.keys() %}
### {{ virtual_hub }}

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com

cd {{ config.configuration_folders.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.gitops.caf_landingzone_branch }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ config.configuration_folders.destination_base_path }}landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.destination_base_path }}{{ config.configuration_folders.destination_relative_path }}/{{ level }}/{{ base_folder }}/virtual_hubs/{{ virtual_hub }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
  -tfstate {{ tfstates.virtual_hubs[virtual_hub].tfstate }} \
  -log-severity ERROR \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan


```
{% endfor %}

## Firewall policies

{% for firewall_policy in tfstates.firewall_policies.keys() %}
### {{ firewall_policy }}

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com

cd {{ config.configuration_folders.destination_base_path }}landingzones
git fetch origin
git checkout {{ config.gitops.caf_landingzone_branch }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ config.configuration_folders.destination_base_path }}landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.destination_base_path }}{{ config.configuration_folders.destination_relative_path }}/{{ level }}/{{ base_folder }}/firewall_policies/{{ firewall_policy }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
  -tfstate {{ tfstates.firewall_policies[firewall_policy].tfstate }} \
  -log-severity ERROR \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan


```
{% endfor %}