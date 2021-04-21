## Components deployed by this example

| Component                  | Type of resource | Purpose                                                      |
|----------------------------|------------------|--------------------------------------------------------------|
| resource group             | Resource group   | resource group to host the cluster and the compute resources |
| Machine Learning Workspace | Workspace        | machine learning workspace                                   |

Please refer here for [architecture diagram](https://github.com/aztfmod/landingzone_data_analytics/tree/0.4/examples/machine_learning)

## Deploying this example

Ensure the below is set prior to apply or destroy.

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment is needed to be defined, otherwise the below LZs will land into sandpit which someone else is working on
export environment=demo
```

## Deploy Machine Learning Workspace

```bash
# Set the folder name of this example
export example="101-aml-workspace"

rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate ${example}.tfstate \
  -var-folder /tf/caf/configuration/${environment}/level3/data_analytics/${example} \
  -parallelism 30 \
  -level level3 \
  -env ${environment} \
  -a [plan|apply|destroy]
```