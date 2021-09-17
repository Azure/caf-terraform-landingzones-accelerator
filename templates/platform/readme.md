
```bash
cd /tf/caf/templates/platform

rover ignite \
  --playbook /tf/caf/starter/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates \
  -e config_folder=/tf/caf/orgs/contoso \
  -e scenario=contoso \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false

```
