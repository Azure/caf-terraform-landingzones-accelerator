# CAF landing zones for Terraform - AKS Single Cluster example

Deploys a Single AKS cluster in a virtual network, with one node pool.

AKS landing zone operates at **level 3**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../../../documentation/code_architecture/hierarchy.md).

## Prerequisites

Before running this example, please make sure you have setup your environment as described in the [following guide](../../readme.md)

## Architecture diagram

This example will sit on the [prerequisites environment](../../readme.md) and will allow you to deploy the following additional topology:

![solutions](../../_pictures/examples/101-single-cluster.PNG)

## Components deployed by this example

| Component                | Type of resource                 | Purpose                                                        |
|--------------------------|----------------------------------|----------------------------------------------------------------|
| aks_re1, aks_nodes_re1   | Resource group                   | resource group to host the cluster and the node pool resources |
| akscluster-001           | AKS Cluster                      | AKS Cluster                                                    |
| acr                      | Azure Container Registry         | Azure Container Registry to store containers                   |
| sharedsvc                | AKS node pool                    | Default node pool for AKS cluster                              |
| managed public IP        | Public IP                        | Public IP address for the node pool.                           |
| managed VMSS             | Virtual Machines Scale Set       | Scale set for the node pool.                                   |
| managed load balancer    | Load balancer                    | Load balancer for the node pool.                               |
| akscluster-001-agentpool | System Assigned Managed Identity | Managed identity for the node pool.                            |

## Deploying this example

Ensure the below is set prior to apply or destroy.

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment needs to be defined, otherwise the below LZs will land into sandpit which someone else is working on
export environment=[YOUR_ENVIRONMENT]
export random_length=10
```

## Run AKS landing zone deployment

```bash
# Set the folder name of this example
example=101-single-cluster

rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate landingzone_aks.tfstate \
  -var-folder /tf/caf/reference_implementations/azure_kubernetes_services/aks/${example} \
  -var tags={example=\"${example}\"} \
  -env ${environment} \
  -level level3 \
  -a [plan|apply|destroy]
```