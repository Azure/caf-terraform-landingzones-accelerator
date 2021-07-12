# CAF landing zones for Terraform - Data Analytics Platform (DAP) landing zone examples

DAP landing zones are designed to fit into an enterprise-scale environment, in this guide, you will find the steps to bootstrap an environment to deploy the DAP landing zones.

## DAP landing zones examples

The CAF landing zone for DAP provides you with the following examples:

## Cloud Adoption Framework layered approach

DAP landing zone operates at **level 3**, so before you are able to deploy them you will need to deploy the prerequisites enterprise landing zones.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/code_architecture/hierarchy.md).

## Setting up your test environment

In order to deploy the data analytics platform landing zones, you must beforehand deploy either a demo or sandpit environment up to and including the level 2 (hub networking).

This can be achieved following the steps there [configuration](../../configuration)

<!-- ### Authenticate to your development environment

We assume that at this step, you have cloned the Data Analytics landing zones repository (this repo) on your machine and have opened it into Visual Studio Code development environment.

Once into the development environment, please use the following steps:

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment is needed to be defined, otherwise the below LZs will land into sandpit which someone else is working on
export environment=[your_environment_name]
git clone -b 2012.1.0 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public

```

### Apply foundations (level 0 and 1)

```bash
# Add the launchpad landingzone if not yet deployed
rover -lz /tf/caf/public/landingzones/caf_launchpad \
  -launchpad \
  -level level0 \
  -var-folder /tf/caf/public/landingzones/caf_launchpad/scenario/100 \
  -env ${environment} \
  -a [plan|apply|destroy]

# Level1
## To deploy dependencies for accounting, apply caf foundations.
rover -lz /tf/caf/public/landingzones/caf_foundations \
  -level level1 \
  -env ${environment} \
  -a [plan|apply|destroy]

# Deploy shared_services typically monitoring, site recovery services, azure image gallery. In this example we don't deploy anything but it will expose the Terraform state to level 3 landing zones, so is required.
rover -lz /tf/caf/public/landingzones/caf_shared_services/ \
  -tfstate caf_shared_services.tfstate \
  -parallelism 30 \
  -level level2 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### Apply network hub (level 2)

The networking hub is part of the core enterprise landing zone services, you can deploy it with the following command:

```bash
#Single Region [For test env]
rover -lz /tf/caf/public/landingzones/caf_networking/ \
  -tfstate networking_hub.tfstate \
  -var-folder /tf/caf/public/landingzones/caf_networking/scenario/100-single-region-hub \
  -tfstate networking_hub.tfstate \
  -env ${environment} \
  -level level2 \
  -a [plan|apply|destroy]

#Multi-region [For enterprise]
rover -lz /tf/caf/public/landingzones/caf_networking/ \
  -tfstate networking_hub.tfstate \
  -var-folder /tf/caf/public/landingzones/caf_networking/scenario/101-multi-region-hub \
  -tfstate networking_hub.tfstate \
  -env ${environment} \
  -level level2 \
  -a [plan|apply|destroy]
``` -->

Once those components are deployed, head to the example folders as below.

### Core DAP landing zone (level 3)

Once the previous steps have been completed, the deployment of the lightweight enterprise scaffold to execute the DAP example landingzones is ready and you can step to one of the examples.

| DAP landing zone example                                                     | Description                                                        |
|------------------------------------------------------------------------------|--------------------------------------------------------------------|
| [101-single-cluster](./databricks/101-simple-cluster)                        | Provision simple databricks cluster                                |
| [101-aml-workspace](./machine_learning/101-aml-workspace)                    | Provision simple machine learning workspace                        |
| [102-aml-workspace-compute](./machine_learning/102-aml-workspace-compute)    | Provision machine learning workspace with compute instance         |
| [101-synapse-workspace](./synapse_analytics/101-synapse-workspace)           | Provision simple Synapse workspace with serverless compute         |
| [102-synapse-workspace-pool](./synapse_analytics/102-synapse-workspace-pool) | Provision Synapse workspace with dedicated SQL pool and Spark pool |
