## Components deployed by this example

| Component         | Type of resource | Purpose                                                 |
|-------------------|------------------|---------------------------------------------------------|
| resource group    | Resource group   | resource group to host the workspace and instance pools |
| synapse workspace | Workspace        | synapse workspace                                       |
| spark pool        | compute          | spark compute cluster                                   |
| sql pool          | compute          | sql compute cluster                                     |

Please refer here for [architecture diagram](https://github.com/aztfmod/landingzone_data_analytics/tree/0.4/examples/synapse_analytics)

## Deploying this example

Ensure the below is set prior to apply or destroy.

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment is needed to be defined, otherwise the below LZs will land into sandpit which someone else is working on
export environment=[YOUR_ENVIRONMENT]
```

## Deploy Azure services for Synapse Workspace

```bash
# Set the folder name - for workspace with dedicated spark or sql pool
export example="102-synapse-workspace-pool"


rover -lz /tf/caf/public/landingzones/caf_solutions/ \
    -var-folder /tf/caf/examples/data_analytics/synapse_analytics/${example} \
    -tfstate ${example}.tfstate \
    -env ${environment} \
    -level level3 \
    -a [plan|apply|destroy]
```
