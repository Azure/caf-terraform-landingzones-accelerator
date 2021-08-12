
# AzureDevOps
Deploy the management services

```bash
# login a with a user member of the caf-maintainers group
rover login -t sergiomiyamaoutlook.onmicrosoft.com

export ARM_USE_AZUREAD=true
caf_env="sandpit"

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/configuration/contoso/platform/demo/level1/gitops/azuredevops/bootstrap \
  -tfstate azure_devops_bootstrap.tfstate \
  -log-severity ERROR \
  -env ${caf_env} \
  -level level1 \
  -a plan

```


# Next steps

 [Deploy Enterprise Scale](../../level1/eslz/readme.md)
 