# Cloud Adoption Framework landing zones for Terraform - Starter template

## SANDPIT ENVIRONMENT

Assumptions:

- Sandpit environment is meant to be run locally and could optionally be run within Azure DevOps pipelines.
- Sandpit environment implements diagnostics and logs for every solution deployed.
- Sandpit environment implements rudimentary RBAC model.
- All resources are provisioned in the same subscription.

:warning: SANDPIT Requires administrative privileges (Azure AD Groups, Applications, API permissions) on your Azure Active Directory to be deployed successfully. Only complete the following steps if you have those permissions or the launchpad deployment will fail.

## Deploying sandpit in Azure DevOps Pipelines

If you want to deploy the sandpit environment into Azure DevOps pipelines, please go [here](./pipelines/README-pipelines.md).

## Deploying with local experience

After completing the steps from the general [configuration readme](../README.md), you can start using the sandpit deployment:

You can then specify the environment you are running:

```bash
export environment=sandpit
export caf_environment=contoso-sandpit

# Note: if you have deployed the demo environment and want to upgrade it to the sandpit configuration,
# set
# export caf_environment=contoso-demo

```

### 1. Launchpad-level0 landing zones

#### Deploy the launchpad

```bash
rover -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder /tf/caf/configuration/${environment}/level0/launchpad \
  -parallelism 30 \
  -level level0 \
  -env ${caf_environment} \
  -launchpad \
  -a [plan|apply|destroy]
```

### 2. Level 1 landing zones

#### Deploy foundations

In this section we use foundations as passthrough:

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate caf_foundations.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level1/foundations \
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

#### Deploy the networking hub (required to add spoke projects)

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate networking_hub.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level2/networking/hub \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

### 4. Level 3 landing zones - Shared infrastructure platforms

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

### 7. Level 4 - Application landing zones

You can use level 4 landing zones to describe and deploy an application on top of a platform described in level 3 landing zones (App Service Environment, AKS, etc.). In this example, we will deploy argocd on top of the cluster deployed in level 3.

#### Deploy argocd on the AKS landing zone

```bash
# Application to deploy
application="argocd"
# Landingzone key hosting the AKS cluster
landingzone_key="cluster_aks"
# Key of the cluster to deploy the application
cluster_key="cluster_re1"

rover -lz /tf/caf/landingzones/caf_solution/add-ons/aks_applications \
  -tfstate landing_zone_aks_level4_demo.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level4/${application} \
  -parallelism 30 \
  -var tags={application=\"${application}\"} \
  -level level4 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```
