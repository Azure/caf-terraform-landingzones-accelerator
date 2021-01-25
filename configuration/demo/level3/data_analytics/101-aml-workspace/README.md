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
export environment=[YOUR_ENVIRONMENT]
```

## Deploy Machine Learning Workspace

```bash
# Set the folder name of this example
export example="101-aml-workspace"

rover -lz /tf/caf \
      -var-folder /tf/caf/landingzone_data_analytics/examples/machine_learning/${example} \
      -tfstate machine_learning_101.tfstate \
	-env ${environment} \
      -level level3 \
      -a [plan|apply|destroy]
```