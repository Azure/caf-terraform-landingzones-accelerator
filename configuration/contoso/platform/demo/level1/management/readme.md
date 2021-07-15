
### Management
Deploy the management services

```bash
# login a with a user member of the caf-maintainers group
rover login -t set_your_tenant_name.onmicrosoft.com

export ARM_USE_AZUREAD=true
caf_env="sandpit"

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/configuration/contoso/platform/demo/level1/management \
  -tfstate management.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a plan

rover logout

```
