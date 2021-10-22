
# To generate the platform configuration

```bash
cd /tf/caf/starter/templates/platform

rover ignite \
  --playbook /tf/caf/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates/platform \
  -e config_folder=/tf/caf/orgs/contoso/standalone/platform \
  -e config_folder_asvm=/tf/caf/orgs/contoso/standalone/asvm \
  -e scenario=configuration \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false


```
