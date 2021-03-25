# Cloud Adoption Framework landing zones for Terraform - Starter template

## DEMO ENVIRONMENT

Assumptions:

- Demo environment does not have pipelines and is meant to be run locally.
- Demo environment does not have diagnostics enabled.
- Demo environment does not have RBAC model.
- All resources are provisioned in the same subscription.

## Deploying demo environment

After completing the steps from the general [configuration readme](../README.md), you can start using the demo deployment:

You can then specify the environment you are running:

```bash
export environment=demo
export caf_environment=contoso-demo
```

### 1. Launchpad-level0 landing zones

#### Deploy the launchpad

```bash
rover -lz /tf/caf/landingzones/caf_launchpad \
  -launchpad \
  -var-folder /tf/caf/configuration/${environment}/level0/launchpad \
  -parallelism 30 \
  -level level0 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 2. Level 1 landing zones

#### Deploy foundations

In this section we use foundations as passthrough:

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate caf_foundations.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level1 \
  -parallelism 30 \
  -level level1 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 3. Level 2 landing zones

#### Deploy the shared services

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate caf_shared_services.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level2/shared_services \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

#### Deploy the networking hub

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate networking_hub.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level2/networking/hub \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 4. Level 3 landing zones

#### Deploy an AKS landing zone

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate landing_zone_aks.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level3/aks \
  -parallelism 30 \
  -level level3 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

#### Deploy a data and analytics landing zone

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate landing_zone_101_aml_workspace.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level3/data_analytics/101-aml-workspace \
  -parallelism 30 \
  -level level3 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

#### Deploy an Azure App Service Environment landing zone

Warning: this is time consuming.

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate landing_zone_ase.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level3/app_service \
  -parallelism 30 \
  -level level3 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 7. Level 4 - Application infrastructure components

You can use level 4 landing zones to describe and deploy an application on top of an environment described in level 3 landing zones (App Service Environment, AKS, etc.).
Keep on monitoring this repository as we will add examples related to this level.
