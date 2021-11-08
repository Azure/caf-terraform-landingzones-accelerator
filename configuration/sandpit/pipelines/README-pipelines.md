# Cloud Adoption Framework landing zones for Terraform - Starter template

## SANDPIT ENVIRONMENT WITH AZURE DEVOPS PIPELINES

Assumptions:

- Sandpit environment implements diagnostics and logs for every solution deployed.
- Sandpit environment implements rudimentary RBAC model.
- All resources are provisioned in the same subscription.

In this example, we will seed the initial deployment locally and then deploy the environment from an Azure DevOps set of pipelines.

## Prerequisite

- VS Code
  - 'Remote - Containers' Extension installed
- Docker 

## 1. Import the starter landing zone into your Azure DevOps environment

### 1.1 Import Starter Landing Zone into your Azure DevOps environment

Go to your Azure DevOps organization (this could be an on premises organization or hosted on http://dev.azure.com), create your first project and then clone the starter repository [this repository](https://github.com/Azure/caf-terraform-landingzones-starter) in your Azure DevOps.
This repository will be called the `caf-configuration` repository in the example pipelines. In order to make things easier, you might want to rename your git repo `caf-configuration` in your DevOps project.

### 1.2 Clone project.

### 1.2.1 Clone and Open within Visual Studio code. 
- With your Azure DevOps REPO, click Clone.
- By generating with Git Credentials allows the project to be checked in from within a container via HTTPS
- Take the password and Azure DevOps Repo URL replace the organization name before @dev.azure.com with the password
```
https://<organizationname>@dev.azure.com/<organizationname>/caf-configuration/_git/caf-configuration
```
becomes
```
https://<password>@dev.azure.com/<organizationname>/caf-configuration/_git/caf-configuration

```
- In the terminal navigate to the folder you wish to clone to.
- Clone
```bash
git clone --branch starter https://<password>@dev.azure.com/<organizationname>/caf-configuration/_git/caf-configuration
```
- Ensure Docker is running

### 1.2.2 Open the project in VSCode
- Open the project in Visual Studio Code
- Ctrl + Shift + P and type `Remote-Containers: Reopen in Container` and select.
- Project now open in container.

## 2. Clone the public landing zones

First step is to get the landing zones logic in the same work space, so let's clone the environment locally:
- Open a VS Code terminal
```bash
git clone --branch 2107.1 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
# Or refresh an existing clone
cd /tf/caf/landingzones
git checkout 2107.1
git pull
```

### 2.2 Login the rover to Azure

Authenticate to your Azure environment using the following command:

```bash
rover login -t <tenant_name> -s <subscription_id>
```

Rover will echo back the subscription selected by default for your environment. If this is not the right subscription, modify it using the following command:

```bash
az account set -s <subscription_name_OR_GUID>
```

## 3 Deploy the devops launchpad and gitops fundamentals

The deployment of an environment via pipeline always starts by deploying the DevOps fundamentals:

1. Launchpad: lays the foundation for Azure components (identity, Key Vaults, state management components)
2. GitOps: create the pipeline, variables to KeyVault, service connection.
3. GitOps agents: the Virtual Machines running the self hosted Azure DevOps agents that will be running the Terraform landing zones from the different levels in your environment.

### 3.1 Level0 - Launchpad

### 3.1.1 Customize Level0 - Launchpad

- Open [diagnostics_destinations.tfvars](../level0/launchpad/diagnostics_destinations.tfvars), change lines 10 & 14 to match the regions you are deploying to.
- Open [landingzone.tfvars](../level0/launchpad/landingzone.tfvars). Add `prefix` just before `regions` and update the regions to match your regions.

```bash
prefix = "<YOUR PREFIX>"

regions = {
  region1 = "uksouth"
  region2 = "ukwest"
}
```
_Note:By not including prefix, random 4 character prefix will be automatically added to your resources_
### 3.1.2 Deploy Level0 - launchpad

```bash
export environment=sandpit

rover -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder /tf/caf/configuration/${environment}/level0/launchpad \
  -parallelism 30 \
  -level level0 \
  -env ${environment} \
  -launchpad \
  -a [plan|apply|destroy]
```

### 3.2 DevOps Personal Access Tokens (PAT)

### 3.2.1 Create Admin PAT

- Within Azure Devops Settings -> Personal Access Tokens. Click New Token.
  - **Name:** azdo-pat-admin
  - **Organization:** _(Your Organization)_
  - **Expiration:** 30 days _(can set Custom defined)_
  - **Scopes:** Full Access.
  - Click Create
- Take note of the Token.

### 3.2.2 Create Agent PAT

- Within Azure Devops Settings -> Personal Access Tokens. Click New Token.
  - **Name:** azdo-pat-agent
  - **Organization:** _(Your Organization)_
  - **Expiration:** 30 days _(can set Custom defined)_
  - **Scopes:** Custom defined.
    - Click `Show all scopes` at the bottom.
    - Under `Agent Pools` tick `Read & manage`
  - Click Create
- Take note of the Token.

### 3.2.3 Store Tokens in Azure Secrets KeyVault

Within your Azure environment from deploying Launchpad, there will be a keyvault in the form of `<prefix>-kv-secrets`. Located in the `<prefix>-rg-launchpad-security` resource group.

- Go to the KeyVault Secrets and update the following Secrets

**AZDO-PAT_ADMIN**

- Click secret named `azdo-pat-admin`
- Click New Version
- Put the Token value you took note of earlier into the 'Value' field and click Create

**AZDO-PAT_AGENT**

- Click secret named `azdo-pat-agent`
- Click New Version
- Put the Token value you took note of earlier into the 'Value' field and click Create

### 3.3 Level 1 - GitOps

### 3.3.1 Deploy the GitOps Connectivity Virtual Network

_No customization are required to work in your environment_

```bash
export environment=sandpit

rover -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/configuration/${environment}/level1/gitops/gitops_connectivity \
  -tfstate gitops_connectivity.tfstate \
  -parallelism 30 \
  -level level1 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 3.3.2 Customize the GitOps Configuration for Azure DevOps

- Open [azure_devops.tfvars](../level1/gitops/azure_devops/azure_devops.tfvars).
  Change the URL to match your Azure DevOps organization in the azure_devops, and the name you gave the project:

```hcl
azure_devops = {

  url     = "https://dev.azure.com/change_with_your_org/"
  project = "caf-configuration"
```

- Into the service connection object, make sure you replace the connection properties with the ones from the launchpad subscription:

```hcl
  service_endpoints = {
    contoso_demo = {
      endpoint_name       = "<Name to show in DEVOPS Service Connections>"
      subscription_name   = "<Name of your subscription>"
      subscription_id     = "<Your SubscriptionID Guid>"
      aad_app_key         = "contoso_demo"
      secret_keyvault_key = "devops"
    }
  }
```

_Note: You can get your subscription ID and Name by running:_

```bash
az account show
```

- Update the variable group `ROVER_IMAGE` to match the rover version you are running in this project. Update the `LANDINGZONE_BRANCH` to match the tag/branch you pulled down in step **2. Clone the public landing zones**.

```hcl

variable_groups = {
    global = {
      name         = "release-global" # changing that name requires to change it in the devops agents yaml variables group
      allow_access = true
      variables = {
        HOME_FOLDER_USER    = "vsts_azpcontainer"
        ROVER_IMAGE         = "aztfmod/<current rover version>"
        ROVER_RUNNER        = "true"
        TF_CLI_ARGS         = "'-no-color'"
        TF_CLI_ARGS_init    = ""
        TF_CLI_ARGS_plan    = "'-input=false'"
        TF_VAR_ARGS_destroy = "'-auto-approve -refresh=false'"
        ENVIRONMENT         = "sandpit"
        LANDINGZONE_BRANCH  = "<Current Branch/Tag>"
      }
    }
```
### 3.3.2.1 Changing the git_repo_name
If you didn't call the project "caf-configuration" when you imported the repo, then you will need to update all `git_repo_name` lines in the [azure_devops.tfvars](../level1/gitops/azure_devops/azure_devops.tfvars). 

- Using a find and replace, replace:
```hcl
git_repo_name = "caf-configuration"
```
with
```hcl
git_repo_name = "<Your Project Name>"
```
### 3.3.3 Deploy the GitOps Configuration for Azure DevOps

```bash
export environment=sandpit

rover -lz /tf/caf/landingzones/caf_solution/add-ons/azure_devops \
  -var-folder /tf/caf/configuration/${environment}/level1/gitops/azure_devops \
  -tfstate azure_devops_contoso_demo.tfstate \
  -parallelism 30 \
  -level level1 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

### 3.3.4 Customize the Azure DevOps Agents (runners)

- Open [landingzones.tfvars](../level1/gitops/azure_devops_agents_vm/landingzones.tfvars).
- Within azure_devops replace all the levels `rover_version` to match the rover version you are running in this project. Change all `url` to match your Azure DevOps organization.

```hcl
azure_devops = {
  level0 ={
    rover_version = "aztfmod/<current rover version>"
    url     = "https://dev.azure.com/<change_with_your_org>/"
  ...
  level1 = {
    rover_version = "aztfmod/<current rover version>"
    url     = "https://dev.azure.com/<change_with_your_org>/"
  ...

```

### 3.3.5 Deploy the Azure DevOps Agents (runners)

```bash
rover -lz /tf/caf/landingzones/caf_solution/add-ons/azure_devops_agent \
  -var-folder /tf/caf/configuration/${environment}/level1/gitops/azure_devops_agents_vm \
  -tfstate azdo-agent-levels.tfstate \
  -parallelism 30 \
  -level level1 \
  -env ${environment} \
  -a [plan|apply|destroy]
```

_Note: First time this is deployed, you may get an error saying the Blob "devops_runtime_baremetal.sh" cannot be parsed. This seems to be a race condition, where it is trying to be read before it has fully uploaded to your storage account. Re-run the apply, it will work from now on._
### 4. Check in your repo code changes back into Azure Devops
First time you attempt to check code in, it might error saying you need to update the username and email of git configuration. 

- Run the following command replacing with your name and email address.
```bash
git config --global user.name "<YOUR NAME>"
git config --global user.email "<YOUR EMAIL>"
```
### 5. Deploy the higher levels from Azure DevOps pipelines

Launchpad and level0 are deployed manually from the console to seed the environment, but all higher levels are deployed using pipelines as defined by the pipelines configuration.

Once the agents are deployed for all levels, you can start deploying the landing zones for the levels:

- Go into your Azure DevOps Pipelines.
- View All Pipelines
- Expand configuration you will see a plan/apply/destroy pipeline within each folder.
  1. full: End to End
  2. level 1: Foundations.
  3. level 2: Networking, Shared Services.
  4. level 3: AKS Cluster, Data and AI, App Service, etc.

### 5.1 End to End

### 5.1.1 logged_in_user issue with Pipelines

When you run End to End pipeline the first time you will see an error message about trying to `logged_in_user` for keyvault access policy, and that the `already exists - to be managed via Terraform this resource needs to be imported into the State.`
This is because when you ran it locally, it added your user account and the MSI to the keyvault. When you run in the pipeline, the current user is the MSI, and it attempts to remove the previous current user (_your user account_) and replace it with the MSI account. However, the MSI was already added previously, but not under the "logged_in_user" key.

- Open [keyvaults.tfvars](../level1/gitops/azure_devops_agents_vm/keyvaults.tfvars).
- Comment out all the 'logged_in_user' sections.

Replace

```hcl
 logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
```

With

```hcl
# logged_in_user = {
#        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
#        # More examples in /examples/keyvault
#        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
#      }
```

- Redeploy step: **3.3.5 Deploy the Azure DevOps Agents (runners)**
- Check in your repo code changes back into Azure Devops.

### 5.1.2 Running Pipelines - End To End

If you would rather deploy each level separately, skip this step and continue from **5.2 Run Pipelines - Level 1**

- Go into Azure Devops Pipelines
- View All Pipelines
- Expand configuration/full
- Select `end_to_end_plan` then click 'Run pipeline'
- Ensure you switch the branch/tag to the name of your branch as _master_ does not exist in this project.
- Click Run.
- Once successful, you can run the `end_to_end_apply` pipeline.

You have now successfully deployed Level 1 - 3 using pipelines, follow the remaining steps only if you wish to deploy levels separately.

### 5.2 Run Pipelines - Level 1

- Go into Azure Devops Pipelines
- View All Pipelines
- Expand configuration/level1
- Select `caf_foundations_plan` then click 'Run pipeline'
- Ensure you switch the branch/tag to the name of your branch as _master_ does not exist in this project.
- Click Run.
- Once successful, you can run the `caf_foundations_apply` pipeline.

### 5.3 Run Pipelines - Level 2

### 5.3.1 Run Pipelines - Level 2 Network Hub.

- Go into Azure Devops Pipelines
- View All Pipelines
- Expand configuration/level2/networking/hub
- Select `caf_networking_hub_plan` then click 'Run pipeline'
- Ensure you switch the branch/tag to the name of your branch as _master_ does not exist in this project.
- Click Run.
- Once successful, you can run the `caf_networking_hub_apply` pipeline.

### 5.3.2 Run Pipelines - Level 2 Shared Services

- Go into Azure Devops Pipelines
- View All Pipelines
- Expand configuration/level2/shared_services
- Select `caf_shared_services_plan` then click 'Run pipeline'
- Ensure you switch the branch/tag to the name of your branch as _master_ does not exist in this project.
- Click Run.
- Once successful, you can run the `caf_shared_services_apply` pipeline.

### 5.4 Run Pipelines - Level 3

### 5.3.1 Run Pipelines - Level 3 AKS

- Go into Azure Devops Pipelines
- View All Pipelines
- Expand configuration/level3/aks
- Select `caf_aks_plan` then click 'Run pipeline'
- Ensure you switch the branch/tag to the name of your branch as _master_ does not exist in this project.
- Click Run.
- Once successful, you can run the `caf_aks_apply` pipeline.

