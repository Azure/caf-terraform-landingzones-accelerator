# Deploy the Hub-Spoke Network Topology

The prerequisites for the [AKS secure baseline cluster](./) are now completed with [Azure AD group and user work](./03-aad.md) performed in the prior steps. Now we will start with our first Azure resource deployment, the network resources.

## Steps

1. Login into the Azure Online subscription that you'll be deploying into.

   > :book: The networking team logins into the Azure subscription that will contain the regional hub. At Contoso Bicycle, all of their regional hubs are in the same, centrally-managed subscription.

   ```bash
   az login --tenant $TENANT_ID
   ```

1. Review the networking.tfvars to adjust the names and CIDR block.

   > :book: The networking team has all their regional networking hubs in the following resource group. The group's default location does not matter, as it's not tied to the resource locations. (This resource group would have already existed.)

   Path location:

   ![network](./pictures/networking_configuration.PNG)

### Next step

:arrow_forward: [Deploy the AKS cluster](./05-aks-cluster.md)
