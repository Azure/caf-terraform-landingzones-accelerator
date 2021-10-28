
# Destroy resources

When finished, please destroy all deployments with the commands below, note that we are destroying landing zones in reverse order comparing to creation:

```bash
cd /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline

# Delete sample application, this contains PodDisruptionBudget that will block Terraform destroy
kubectl delete -f workloads/baseline

caf_env="es-aks"
```
## Level 2


### AKS Secure Baseline
```bash

rover \
  -lz /tf/caf/landingzones/caf_solution/add-ons/aks_secure_baseline_v2 \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level2/aks_secure_baseline \
  -tfstate aks_secure_baseline.tfstate \
  -env ${caf_env} \
  -level level2 \
  -a destroy
```

### AKS
```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level2/aks \
  -tfstate aks.tfstate \
  -env ${caf_env} \
  -level level2 \
  -a destroy

```



## Level 1

### Networking Spoke

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level1/networking_spoke \
  -tfstate networking_spoke.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a destroy

```

### Networking Hub

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level1/networking_hub \
  -tfstate networking_hub.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a destroy

```

### Shared Services

```bash

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level1/shared_services \
  -tfstate shared_services.tfstate \
  -env ${caf_env} \
  -level level1 \
  -a destroy

```

## Level 0

### Launchpad

```bash

rover \
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level0/launchpad \
    -launchpad \
    -env ${caf_env} \
    -level level0 \
    -a destroy
```