
### Management
Deploy Enteprise Scale

Note you need to adjust the branch to deploy Enterprise Scale eslz.0.3.3

```bash
# login a with a user member of the caf-maintainers group
rover login -t set_your_tenant_name.onmicrosoft.com

cd /tf/caf/landingzones
git fetch origin
git checkout eslz.0.3.3

export ARM_USE_AZUREAD=true
caf_env="sandpit"

rover \
  -lz /tf/caf/landingzones/caf_solution/add-ons/caf_eslz \
  -var-folder /tf/caf/configuration/contoso/platform/demo/level1/eslz \
  -tfstate eslz.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a plan

```

# Next steps

 [Deploy Connectivity](../../level2/connectivity/readme.md)
 