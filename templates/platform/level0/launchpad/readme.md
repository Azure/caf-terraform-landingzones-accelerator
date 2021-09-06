# Launchpad - scenario {{ scenario }} / {{ model }}

The {{ model }} scenario is designed to demonstrate a basic functional foundations to store Terraform state on Azure storage and use it centrally.
The focus of this scenario is to be able to deploy a basic launchpad from a remote machine and use the portal to review the settings in a non-constrained environment.
For example in this scenario you can go to the Key Vaults and view the secrets from the portal, a feature that is disabled in the 300+ scenarios.
We recommend using the 100 scenario for demonstration purposes.

An estimated time of 5 minutes is required to deploy this scenario.

## Pre-requisites

This scenario require the following privileges:

| Component          | Privileges         |
|--------------------|--------------------|
| Active Directory   | None               |
| Azure subscription | Subscription owner |

## Deployment


### Pre-requisite

Elevate your credentials to the tenant root level to have enough privileges to create the management group hierarchy.

```bash
{% if config.billing_subscription_role_delegations.enable %}
# Login to the subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_name }} with the user {{ config.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_name }} with an account owner.
{% endif %}
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com
az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01"

```

### Launchpad

```bash
{% if config.billing_subscription_role_delegations.enable %}
# Login to the subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_name }} with the user {{ config.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_name }} with an account owner.
{% endif %}
rover login -t {{ config.platform_identity.tenant_name }}.onmicrosoft.com -s {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }}

cd /tf/caf/landingzones
git fetch origin
git checkout {{ config.gitops.caf_landingzone_branch }}

rover \
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder {{ config.configuration_folders.destination_base_path }}{{ config.configuration_folders.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -target_subscription {{ config.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -tfstate {{ tfstates.launchpad.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -launchpad \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -a plan

```

## Architecture diagram
![Launchpad {{ model }}](../../../../../../documentation/img/launchpad-{{ model }}.PNG)


# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

{% if config.billing_subscription_role_delegations.enable %}
 [Deploy the billing subscription role delegation](../billing_subscription_role_delegations/readme.md)
{% else %}
 [Deploy the management services](../../level1/management/readme.md)
{% endif %}