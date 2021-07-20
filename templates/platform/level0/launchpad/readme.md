
# Launchpad
Set-up the launchpads for level0 to level3 to store the remote states in Azure storage accounts

```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.tenant_name }}.onmicrosoft.com

export ARM_USE_AZUREAD=true
caf_env="{{ config.launchpad.caf_environment }}"

rover \
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder {{ config.destination_install_path }}{{ config.destination_relative_base_path }}/{{ level }}/{{ base_folder }} \
  -tfstate {{ tfstates.launchpad.tfstate }} \
  -log-severity ERROR \
  -launchpad \
  -env ${caf_env} \
  -level {{ level }} \
  -a plan

```

if you have some errors during the deployment of the launchpad you must fix them first before proceeding to the next step. Failing to do that will prevent the rover to locate a launchpad.

# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

 [Deploy the management services](../../level1/management/readme.md)
 

# Components deployed in the launchpad

| Components                                                                                              | Config files                                                 | Description|
|-----------------------------------------------------------|------------------------------------------------------------|------------------------------------------------------------|
| Global Settings |[global_settings.tfvars](./global_settings.tfvars) | Primary Region setting. Changing this will redeploy the whole stack to another Region|
| Resource Groups | [resource_groups.tfvars](./resource_groups.tfvars)| Resource groups configs |
||<p align="center">**Identity & Access Management**</p>||
| Identity & Access Management | [azuread_api_permissions.tfvars](./azuread_api_permissions.tfvars) <br /> [azuread_applications.tfvars](./azuread_applications.tfvars) <br /> [service_principals.tfvars](./service_principals.tfvars) <br /> [azuread_groups.tfvars](./azuread_groups.tfvars) <br /> [azuread_roles.tfvars](./azuread_roles.tfvars) <br /> [role_mappings.tfvars](./role_mappings.tfvars)| AAD admin group, Service Principals & Role Assignments |
||<p align="center">**Security**</p>||
| Azure Key Vault| [keyvaults.tfvars](./keyvaults.tfvars) <br />  [keyvault_policies.tfvars](./keyvault_policies.tfvars) <br /> [dynamic_secrets.tfvars](./dynamic_secrets.tfvars) <br />  | Key Vault , policies and dynamic secrets for the rover |
||<p align="center">**Storage**</p>||
| Storage account| [storage_accounts.tfvars](./storage_accounts.tfvars) <br />| Azure Storage account to store the tfstates |
<br />