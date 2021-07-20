
# Firewall Policy


```bash
# login a with a user member of the caf-maintainers group
rover login -t set_your_tenant_name.onmicrosoft.com

cd /tf/caf/landingzones
git fetch origin
git checkout 2107.1

export ARM_USE_AZUREAD=true
caf_env="sandpit"

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/configuration/contoso/platform/demo/level2/connectivity/firewall_policies/root \
  -tfstate connectivity_firewall_policy_root.tfstate \
  -log-severity ERROR \
  -env ${caf_env} \
  -level level2 \
  -a plan


```
