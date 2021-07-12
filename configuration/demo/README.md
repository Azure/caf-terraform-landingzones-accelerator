# Cloud Adoption Framework landing zones for Terraform - Enterprise Scale Demo

## CONTOSO DEMO ARCHITECTURE

https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md

![contoso](./pictures/ns-vwan.png)

This implementation gives you a very simplified entreprise-scale deployment to illustrate the fundamentals of Terraform enterprise-composition and state management with Cloud Adoption Framework.

The following deviations from enterprise-scale criterias are conciously taken to simply this scenario:
- This environment is meant to be run locally (no sample pipelines provided), for education purposes.
- This environment implements rudimentary RBAC model.
- All resources are provisioned in the same subscription by default, but can be spread accross multiple pre-created subscriptions.

You will find other scenarios that are more aligned with enterprise-scale criter under the other directories (sandpit, non-prod and prod folders)

<!--
Critical design area deviation table
| Critical Design Area  | Demo | Sandpit | Prod |
| -- | -- | -- | -- |  -->


## Deploying with local experience

After completing the steps from the general [configuration readme](../README.md), you can start using the sandpit deployment:

You can then specify the environment you are running:

```bash
caf_environment=contoso-demo
```

### 1. Launchpad-level0 landing zones

The launchpad sets the fundamentals of Terraform for utilization with Azure: Storage Accounts and Azure Key Vaults to host the different levels of the Cloud Adoption Framework levels, rudimentary RBAC, global settings, and naming convention for the deployment.

#### Deploy the launchpad

```bash
rover -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder /tf/caf/configuration/demo/level0/launchpad \
  -parallelism 30 \
  -level level0 \
  -env ${caf_environment} \
  -launchpad \
  -a [plan|apply|destroy]
```

### 2. Level 1 landing zones

#### Deploy management subscription

This layer deploys the resources for the management subscription:

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -var-folder /tf/caf/configuration/demo/level1/management \
  -tfstate management.tfstate \
  -parallelism 30 \
  -level level1 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

<!-- If you want to deploy this into a diferrent subscription, you can run:
```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -TF_VAR_tfstate_subscription_id=
  -target_subscription=<target_subscription>
  -var-folder /tf/caf/configuration/demo/level1/management \
  -tfstate management.tfstate \
  -parallelism 30 \
  -level level1 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
``` -->

<!-- #### [Optional] Deploy Enterprise-Scale components

This command is optional, run it only if you have tenant-level access to your subscription, otherwise you can skip. Keeping in mind you wont have management groups and policies related to enterprise-scale.

```bash
rover -lz /tf/caf/landingzones/caf_solution/add-ons/caf_eslz/ \
  -var-folder /tf/caf/configuration/demo/level1/eslz \
  -tfstate caf_eslz.tfstate \
  -parallelism 30 \
  -level level1 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
``` -->

#### Deploy the identity subscription

This layer deploys the resources for the identity subscription:

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate identity.tfstate \
  -var-folder /tf/caf/configuration/demo/level1/identity \
  -parallelism 30 \
  -level level1 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```


### 3. Level 2 landing zones

#### Deploy the connectivity subscription with Virtual WAN

This layer deploys the resources for the Virtual WAN topology in the connectivity subscription:

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate connectivity_virtual_wan.tfstate \
  -var-folder /tf/caf/configuration/demo/level2/connectivity/virtual_wan \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
```

<!-- ### 3. Level 3 landing zones

#### Deploy an application landing zone

```bash
rover -lz /tf/caf/landingzones/caf_solution/ \
  -tfstate connectivity_virtual_wan.tfstate \
  -var-folder /tf/caf/configuration/demo/level2/connectivity/virtual_wan \
  -parallelism 30 \
  -level level2 \
  -env ${caf_environment} \
  -a [plan|apply|destroy]
``` -->
