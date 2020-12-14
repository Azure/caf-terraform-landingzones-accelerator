# Cloud Adoption Framework landing zones for Terraform - Starter template

## SANDPIT ENVIRONMENT

Assumptions:

- Sandpit environment is meant to be run locally and could optionally be run within Azure DevOps pipelines.
- Sandpit environment implements diagnostics and logs for every solution deployed.
- Sandpit environment implements rudimentary RBAC model.
- All resources are provisioned in the same subscription.

## Deploying a sandpit environment

After completing the steps from the general [configuration readme](../README.md), you can start using the sandpit deployment:

You can then specify the environment you are running:
```bash
export environment=sandpit
```

### 1. Launchpad-level0 landing zones

#### Deploy the launchpad

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad \
  -var-folder /tf/caf/configuration/${environment}/level0/launchpad \
  -parallelism 30 \
  -level level0 \
  -env ${environment} \
  -launchpad \
  -a [plan|apply|destroy]
```

### 2. Level 1 landing zones

#### Deploy foundations

In this section we use foundations as passthrough:

```bash
rover -lz /tf/caf/public/landingzones/caf_foundations/ \
  -var-folder /tf/caf/configuration/${environment}/level1 \
  -parallelism 30 \
  -level level1 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 3. Level 2 landing zones

#### Deploy the shared services

```bash
rover -lz /tf/caf/public/landingzones/caf_shared_services/ \
  -tfstate caf_shared_services.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level2/shared_services \
  -parallelism 30 \
  -level level2 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

#### Deploy the networking hub (required to add parallel spoke projects)

```bash
rover -lz /tf/caf/public/landingzones/caf_networking/ \
  -tfstate networking_hub.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level2/networking/hub \
  -parallelism 30 \
  -level level2 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 4. Level 3 landing zones - Shared infrastructure platforms

#### Deploy the networking spoke

```bash
rover -lz /tf/caf/public/landingzones/caf_networking/ \
  -tfstate networking_spoke_aks.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level3/networking/spoke \
  -parallelism 30 \
  -level level3 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

#### Deploy the Azure Kubernetes Services landing zone

#### Clone the AKS landing zone files

git clone https://github.com/aztfmod/landingzone_aks.git /tf/caf/landing_zone_aks

#### Deploy the AKS cluster

```bash
rover -lz /tf/caf/landing_zone_aks \
  -tfstate landing_zone_aks.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level3/aks \
  -parallelism 30 \
  -level level3 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 7. Level 4 - Application infrastructure components

You can use level 4 landing zones to describe and deploy an application on top of an environment described in level 3 landing zones (App Service Environment, AKS, etc.).
Keep on monitoring this repository as we will add examples related to this level.
