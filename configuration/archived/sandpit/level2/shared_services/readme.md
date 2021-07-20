# Cloud Adoption Framework for Azure - Landing zones on Terraform - Shared services

The Shared services landing zone allows you to management components on Microsoft Azure, typically:

* Monitoring
* Azure Site Recovery
* Azure Backup
* Azure Automation

Shared services landing zone operates at **level 2**.

It is **important** to deploy shared services landing zone, even in passthrough mode as it will export some shared parameters and settings from level1 landing zones.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).
