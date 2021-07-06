# CAF landing zones for Terraform - AKS private cluster example

Deploys an AKS private cluster in a hub & spoke topology with user defined routes redirection via Azure Firewall for egress traffic.

AKS landing zone operates at **level 3**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../../../documentation/code_architecture/hierarchy.md).

## Prerequisites

Before running this example, please make sure you have setup your environment /!\ WITHOUT THE NETWORKING layers, as described in the [following guide](../../readme.md)

## Architecture diagram

This example will sit on the [prerequisites environment](../../readme.md) and will allow you to deploy the following additional topology:

![solutions](../../../_pictures/examples/104-full.PNG)

## Components deployed by this example

| Component                               | Type of resource                 | Purpose                                                                 |
|-----------------------------------------|----------------------------------|-------------------------------------------------------------------------|
| aks_re1, aks_jumpbox_re1, aks_nodes_re1 | Resource group                   | resource group to host the cluster, the node pool and jumpbox resources |
| akscluster-001                          | AKS Cluster                      | AKS Cluster                                                             |
| acr                                     | Azure Container Registry         | Azure Container Registry                                                |
| sharedsvc on akscluster-001             | AKS node pool                    | re1-001 node pool available within 3 availability zones.                |
| managed VMSS                            | Virtual Machines Scale Sets      | Scale sets for the node pools.                                          |
| managed load balancer                   | Load balancer                    | Load balancer for the node pools.                                       |
| akscluster-001  agentpool               | System Assigned Managed Identity | Managed identity for the node pools.                                    |
| private links                           | Private link                     | Private link for ACR and AKS API                                        |
| network interface cards                 | network interface cards          | NIC for private link for AKS cluster and ACR                            |

## Deploying this example

Ensure the below is set prior to apply or destroy.

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment is needed to be defined, otherwise the below LZs will land into sandpit which someone else is working on
environment=[YOUR_ENVIRONMENT]
```

### Deploy enhanced networking model

In this section we add the Azure Firewall in the regional hub.

```bash
# The following command extends the networking hub 101-multi-region-hub

example="104-private-cluster"

rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate networking_hub.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level2/networking/hub \
  -var-folder /tf/caf/reference_implementations/azure_kubernetes_services/aks/${example}/networking_hub/single_region \
  -env ${environment} \
  -level level2 \
  -a [plan|apply|destroy]

# You can add -var-folder /tf/caf/examples/aks/${example}/networking_hub/diagnostics \ # Uncomment to enable diagnotics
```

### Run AKS landing zone deployment

```bash
example=104-private-cluster
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate landingzone_aks.tfstate \
  -var-folder /tf/caf/reference_implementations/azure_kubernetes_services/aks/${example} \
  -var tags={example=\"${example}\"} \
  -env ${environment} \
  -level level3 \
  -a [plan|apply|destroy]
```

<!--
### Run AKS landing zone deployment (in a multi-subscription environment)

```bash
#Set the folder name of this example
example=104-private-cluster
TF_VAR_tfstate_subscription_id="<id of the launchpad subscription>"
target_subscription="<name of the subscription to deploy AKS>"

rover -lz /tf/caf/ \
  -tfstate_subscription_id ${TF_VAR_tfstate_subscription_id} \
  -target_subscription "${target_subscription}" \
  -tfstate landingzone_aks.tfstate \
  -var-folder /tf/caf/examples/aks/${example} \
  -var tags={example=\"${example}\"} \
  -env ${environment} \
  -level level3 \
  -a [plan|apply]
``` -->
