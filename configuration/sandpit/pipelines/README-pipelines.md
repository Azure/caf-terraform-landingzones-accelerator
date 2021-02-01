# Cloud Adoption Framework landing zones for Terraform - Starter template

## SANDPIT ENVIRONMENT WITH AZURE DEVOPS PIPELINES

Assumptions:

- Sandpit environment implements diagnostics and logs for every solution deployed.
- Sandpit environment implements rudimentary RBAC model.
- All resources are provisioned in the same subscription.

In this example, we will seed the initial deployment locally and then deploy the environment from an Azure DevOps set of pipelines.

## 1. Import the starter landing zone into your Azure DevOps environment

Go to your Azure DevOps organization (this could be an on premises organization or hosted on http://dev.azure.com), create your first project and then clone the starter repository (this repository) in your Azure DevOps.
This repository will be called the ```configuration``` repository in the example pipelines. In order to make things easier, you might want to rename your git repo ```configuration``` in your DevOps project.

## 2. Deploy the devops launchpad and initial devops agent

The deployment of an environment via pipeline always starts by deploying the DevOps fundamentals:

1. Launchpad: lays the foundation for Azure components.
2. DevOps: create the pipeline, variables to KeyVault, service connection.
3. DevOps agents: the Virtual Machines running the self hosted Azure DevOps agents that will be running the Terraform landing zones fro the different levels in your environment.

### 2.1. Customize and deploy launchpad landing zones


```bash
environment=sandpit

rover -lz /tf/caf/public/landingzones/caf_launchpad \
  -var-folder /tf/caf/configuration/${environment}/level0/launchpad \
  -parallelism 30 \
  -level level0 \
  -env ${environment} \
  -launchpad \
  -a [plan|apply|destroy]
```

### 2.2 Customize and deploy the Azure DevOps configuration

Customize your Azure DevOps environment as discussed [here](https://github.com/Azure/caf-terraform-landingzones/tree/master/landingzones/caf_launchpad/add-ons/azure_devops).

We assume the project "contoso_demo" has already been created in your Azure DevOps organization and permissions defined as required.

Go to your Azure Subscription and locate your DevOps secrets Key Vault.  It is by default called in the form of <prefix>-kv-secrets.

Inside this Key Vault, create and import the following secrets:

| Name of the secret | Value                                                       |
|--------------------|-------------------------------------------------------------|
| azdo-pat-admin     | A PAT token with full privileges on the project.            |
| azdo-pat-agent     | A PAT token with restricted privileges for agent management |

Into the service connection object, make sure you replace the connection properties with the ones from the launchpad subscription:

```hcl
  service_endpoints = {
    contoso_demo = {
      endpoint_name       = "ES-Devops-launchpad"
      subscription_name   = "ES-Devops-launchpad"
      subscription_id     = "GUID"
      aad_app_key         = "contoso_demo"
      secret_keyvault_key = "devops"
    }
  }
```

You can get your subscription ID running:

```bash
az account show
```

Once those values are imported, you can run the landing zones for Azure DevOps configuration.

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad/add-ons/azure_devops \
  -var-folder /tf/caf/configuration/${environment}/level0/azure_devops \
  -tfstate azure_devops_contoso_demo.tfstate \
  -parallelism 30 \
  -level level0 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 3. Customize and deploy the Azure DevOps Agents add-ons for level 0

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad/add-ons/azure_devops_agent \
  -var-folder /tf/caf/configuration/${environment}/level0/azure_devops_agents \
  -tfstate azdo-agent-level0.tfstate \
  -parallelism 30 \
  -level level0 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 4. Deploy the higher levels from Azure DevOps console

Launchpad and level0 are deployed manually from the console to seed the environment, but all higher levels are deployed using pipelines as defined by the pipelines configuration.

As such, go to the Azure DevOps Console and deploy the following pipelines:
1. DevOps Agent: level 1
2. DevOps Agent: level 2
3. DevOps Agent: level 3

Once the agents are deployed for all levels, you can start deploying the landing zones for the levels:
1. Level 1.
2. Level 2: Networking, Shared Services.
3. Level 3: AKS Cluster, Data and AI, App Service, etc.