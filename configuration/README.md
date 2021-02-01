# Cloud Adoption Framework landing zones for Terraform - Starter template

## Creating your environment

When creating a new environment with landing zone, you will customize and deploy the levels from the level 0 up to level 4. It is important to respect that order to deploy the enterprise configuration and hierarchy as per the [following guidance](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/code_architecture/hierarchy.md).

This means configuring the different variables for:

- Launchpad (remote state management, security, bastion host, Azure DevOps environment, and DevOps agents, GitHub or Terraform Cloud)
- Foundations
- Networking (hub network, Virtual WAN, Application Gateway, etc.)
- Any application landing zone (data and analytics, Azure Kubernetes Services, etc.)

In order to create those customized configuration environment, you can leverage:

* the examples present in this repository,
* the on the CAF landing zone [main repo](https://github.com/Azure/caf-terraform-landingzones)
* discuss with peers on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## General getting started

### 1. Clone the public landing zones

First step is to get the landing zones logic in the same work space, so let's clone the environment locally:

```bash
git clone --branch 2101.0.0 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public

# Or refresh an existing clone
cd /tf/caf/public
git checkout 2101.0.0
git pull
```

Note that if you want to be able to edit the code and submit back a pull request to the community, you can also fork it in your own GitHub environment and clone it from there.

### 2. Login the rover to Azure

Authenticate to your Azure environment using the following command:

```bash
rover login -t <tenant_name> -s <subscription_id>
```

Rover will echo back the subscription selected by default for your environment. If this is not the right subscription, modify it using the following command:

```bash
az account set -s <subscription_name_OR_GUID>
```

### Picking your environment

Once you have completed the preliminary steps above, you can start reviewing the configurations, we recommend you start your first deployment with the demo section.

| example environment    | description                                                                      |
|------------------------|----------------------------------------------------------------------------------|
| [demo](./demo)         | demo environment without RBAC, diagnostics and pipelines                         |
| [sandpit](./sandpit)   | initial enterprise environment, with diagnostics and simple pipelines (optional) |
| [non-prod](./non-prod) | WIP                                                                              |
| [prod](prod)           | WIP                                                                              |

## Multiple engineers in the same subscription

If you want to have multiple users in the same subscription. In order to manage different working environment, we use the ```-env <name_of_environment>``` to create multiple environments in the same subscription.

It will allow you to:

- store the Terraform state into dedicated containers.
- allow only the user that created the environment to access the state.
- tag the deployment with the environment name.

At anytime on a given subscription you can use the following command to see the different environments deployed:

```bash
rover landingzone list -level level0
```

## Community

Feel free to open an issue for feature or bug, or to submit a PR.

In case you have any question, you can reach out to tf-landingzones at microsoft dot com.

You can also reach us on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
