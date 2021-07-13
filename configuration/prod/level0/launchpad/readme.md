
### Launchpad
Set-up the launchpads for level0 to level3

```bash
# login a with a user member of the caf-maintainers group
rover login -t <tenant_name>.onmicrosoft.com

export ARM_USE_AZUREAD=true
caf_env="prod"

rover \
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder /tf/caf/configuration/prod/level0/launchpad \
  -tfstate caf_launchpad.tfstate \
  -launchpad \
  -env ${caf_env} \
  -level level0 \
  -a plan

rover logout

```


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