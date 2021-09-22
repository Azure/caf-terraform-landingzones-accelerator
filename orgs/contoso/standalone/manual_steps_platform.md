
# To generate the platform configuration

```bash
cd /tf/caf/starter/templates/platform

rover ignite \
  --playbook /tf/caf/starter/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates \
  -e config_folder=/tf/caf/orgs/contoso/standalone \
  -e scenario=single_subscription \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false

```

## Deploy the launchpad

Refer to configuration folder


```bash
cd /tf/caf/starter/templates/platform

rover ignite \
  --playbook /tf/caf/starter/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates \
  -e config_folder=/tf/caf/orgs/contoso/standalone \
  -e scenario=single_subscription \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false


```

## Deploy other services:

- management
- eslz
- connectivity