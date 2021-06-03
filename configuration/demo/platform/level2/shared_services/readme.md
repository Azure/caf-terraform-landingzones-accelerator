# Cloud Adoption Framework for Azure - Landing zones on Terraform - Shared services

The Shared services landing zone allows you to management components on Microsoft Azure, typically:

* Monitoring
* Azure Site Recovery
* Azure Backup
* Azure Automation

Shared services landing zone operates at **level 2**.

It is **important** to deploy shared services landing zone, even in passthrough mode as it will export some shared parameters and settings from level1 landing zones.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/code_architecture/hierarchy.md).

## Deploymnet

Please refer to the getting started and local deployment rover commands found in the demo folder [README.md](../../README.md).

## Components deployed by this example

| Component                                                                        | Type of resource        | Purpose                                                                                    |
|----------------------------------------------------------------------------------|-------------------------|--------------------------------------------------------------------------------------------|
| sharedsvc_re1                                                                    | Resource group          | resource group to host the shared services                                                 |
| vault_re1                                                                        | Recovery Vault          | recovery vault with daily backup policies                                                  |
| autore1                                                                          | Automations             | automation account                                                                         |

## Customizing this example

Please review the configuration files and make sure you are deploying in the expected region and with the expected settings.

