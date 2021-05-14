# Deployment steps

NOTE: before proceeding, owner of the subscription is required.

## Login the Azure AD Tenant

```bash
TENANT_ID
SUB_ID
rover login -t $TENANT_ID -s $SUB_ID
az account set -s
```

## Prerequisites

```bash
git clone --branch azure_devops_v1 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
```

## Level 0

### Launchpad
Set-up the launchpads for level0 to level4

```bash
caf_env="es-aks"
# TF_VAR_tfstate_subscription_id=""
# target_subscription=""

rover \
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/landingzone/online/aks_secure_baseline/configuration/level0/launchpad \
    -launchpad \
    -env ${caf_env} \
    -level level0 \
    -a plan
```

### Shared Services

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/landingzone/online/aks_secure_baseline/configuration/level1/shared_services \
  -tfstate caf_shared_services.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a plan

```
### Networking Hub

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/landingzone/online/aks_secure_baseline/configuration/level1/networking_hub \
  -tfstate networking_hub.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a plan

```

### Networking Spoke

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/landingzone/online/aks_secure_baseline/configuration/level1/networking_spoke \
  -tfstate networking_spoke.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a plan

```

### AKS

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/landingzone/online/aks_secure_baseline/configuration/level2/aks \
  -tfstate aks.tfstate \
  -env ${caf_env} \
  -level level2 \
  -a plan

```