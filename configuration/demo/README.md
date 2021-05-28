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

## Platform deployments

The first 3 levels (0, 1 & 2) consist of platform resources. In some cases there may be level 3 platform resources as well. These are grouped toghether because the deployment permission in an enterprise setting may be elevated, for seperation of concerns from applicaiton development, the frequency of deployment should be lower, and multiple applications can be deployed against one platform.

Platform and application folders may also be stored in diferent repositories to help manage enterprise needs. A third common repository should also be created for the landing zones and imported through your pipeline deployment process.

### 1. Launchpad-level0 landing zones

#### Deploy the launchpad

```bash
rover -lz /tf/caf/landingzones/caf_launchpad \
  -tfstate launchpad.tfstate
  -launchpad \
  -var-folder /tf/caf/configuration/${environment}/platform/level0/launchpad \
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
  -tfstate foundations.tfstate \
  -var-folder /tf/caf/configuration/${environment}/platform/level1/foundations \
  -parallelism 30 \
  -level level1 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 3. Level 2 landing zones

#### Deploy the shared services

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate shared_services.tfstate \
  -var-folder /tf/caf/configuration/${environment}/platform/level2/shared_services \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

#### Deploy the networking hub

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate network_hub.tfstate \
  -var-folder /tf/caf/configuration/${environment}/platform/level2/networking/network_hub \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

## Application deployments

The levels 3 and 4 are where application deployments live. There may be multiple versions or different application configurations which can be created and destroyed as needed without impacting the platform deployments.

### 4. Level 3 landing zones

#### Deploy an AKS landing zone

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate aks_cluster.tfstate \
  -var-folder /tf/caf/configuration/${environment}/application/level3/aks_cluster \
  -parallelism 30 \
  -level level3 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

#### Deploy a data and analytics landing zone

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate aml_workspace.tfstate \
  -var-folder /tf/caf/configuration/${environment}/application/level3/data_analytics/aml_workspace \
  -parallelism 30 \
  -level level3 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

#### Deploy an Azure App Service Environment landing zone

Warning: this is time consuming.

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate app_service.tfstate \
  -var-folder /tf/caf/configuration/${environment}/application/level3/app_service \
  -parallelism 30 \
  -level level3 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 7. Level 4 - Application infrastructure components

You can use level 4 landing zones to describe and deploy an application on top of an environment described in level 3 landing zones (App Service Environment, AKS, etc.).
Keep on monitoring this repository as we will add examples related to this level.
