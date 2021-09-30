
```bash
cd /tf/caf/templates/platform

rover ignite \
  --playbook /tf/caf/starter/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates \
  -e config_folder=/tf/caf/orgs/contoso/multi-sub/platform \
  -e config_folder_asvm=/tf/caf/orgs/contoso/multi-sub/asvm \
  -e scenario=demo \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false

```
