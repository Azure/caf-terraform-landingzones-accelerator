# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Subscription Vending Machine (ASVM)


```bash
cd /tf/caf/templates/platform

rover ignite \
  --playbook /tf/caf/starter/templates/asvm/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates \
  -e config_folder=/tf/caf/orgs/contoso/asvm \
  -e platform_config_folder=/tf/caf/orgs/contoso/platform \
  -e scenario=contoso \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false

```
