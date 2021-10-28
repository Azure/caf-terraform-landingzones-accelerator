# Launchpad - {{ config.caf_terraform.launchpad.caf_environment }}

The scenario is designed to demonstrate a basic functional foundations to store Terraform state on Azure storage and use it centrally.
The focus of this scenario is to be able to deploy a basic launchpad from a remote machine and use the portal to review the settings in a non-constrained environment.
For example in this scenario you can go to the Key Vaults and view the secrets from the portal, a feature that is disabled in the 300+ scenarios.

An estimated time of 5 minutes is required to deploy this scenario.

## Pre-requisites

This scenario requires the following privileges:

| Component          | Privileges         |
|--------------------|--------------------|
| Active Directory   | None               |
| Azure subscription | Subscription owner |

## Deployment

{% if config.caf_terraform.billing_subscription_role_delegations is defined %}
### Pre-requisite

Elevate your credentials to the tenant root level to have enough privileges to create the management group hierarchy.

```bash
{% if config.caf_terraform.billing_subscription_role_delegations.enable %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with an account owner.
{% endif %}
rover login -t {{ config.platform_identity.tenant_name }}
az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01"

```
{% endif %}

### Launchpad

```bash
{% if config.caf_terraform.billing_subscription_role_delegations is defined %}
{% if config.caf_terraform.billing_subscription_role_delegations.enable %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with an account owner.
{% endif %}
{% endif %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ config.caf_terraform.launchpad.subscription_id }}

cd /tf/caf/landingzones
git fetch origin
git checkout {{ config.gitops.caf_landingzone_branch }}

rover \
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ tfstates.launchpad.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -launchpad \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstates.launchpad.tfstate }}.tfplan \
  -a plan

```

## Architecture diagram
![Launchpad demo](../../../../../../documentation/img/launchpad-demo.PNG)


# Next steps

When you have successfully deployed the launchpad you can  move to the next step.


{% if config.caf_terraform.billing_subscription_role_delegations is defined %}
{% if config.caf_terraform.billing_subscription_role_delegations.enable %}
 [Deploy the billing subscription role delegation](../billing_subscription_role_delegations/readme.md)
{% else %}
 [Deploy the management services](../../level1/management/readme.md)
{% endif %}
{% else %}
 [Deploy the management services](../../level1/management/readme.md)
{% endif %}