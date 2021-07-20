
# Connectivity
You have selected the vwan networking option to build your Enteprise Scale platform. The following instructions guides you through the steps to follow.

## Select the correct branch for the landingzones code

Note you need to adjust the branch 2107.1 to deploy the connectivity services

## Virtual Wan

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
  -var-folder /tf/caf/configuration/contoso/platform/demo/level2/connectivity/virtual_wan \
  -tfstate connectivity_virtual_wan.tfstate \
  -env ${caf_env} \
  -level level2 \
  -a plan

```

## Virtual hubs

### hub1

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
  -var-folder /tf/caf/configuration/contoso/platform/demo/level2/connectivity/virtual_hubs/hub1 \
  -tfstate connectivity_virtual_hub1.tfstate \
  -log-severity ERROR \
  -env ${caf_env} \
  -level level2 \
  -a plan


```
### hub2

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
  -var-folder /tf/caf/configuration/contoso/platform/demo/level2/connectivity/virtual_hubs/hub2 \
  -tfstate connectivity_virtual_hub2.tfstate \
  -log-severity ERROR \
  -env ${caf_env} \
  -level level2 \
  -a plan


```

## Firewall policies

### root

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
### non_prod

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
  -var-folder /tf/caf/configuration/contoso/platform/demo/level2/connectivity/firewall_policies/non_prod \
  -tfstate connectivity_firewall_policy_non_prod.tfstate \
  -log-severity ERROR \
  -env ${caf_env} \
  -level level2 \
  -a plan


```
