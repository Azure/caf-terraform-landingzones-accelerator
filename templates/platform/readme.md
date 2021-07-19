
```bash
cd /tf/caf/templates/platform && \
ansible-playbook e2e.yaml \
  -e base_templates_folder=/tf/caf/templates/platform \
  -e config_folder=/tf/caf/enterprise_scale/contoso/platform \
  -e scenario=contoso \
  -e model=demo

# Level2
cd /tf/caf/templates/platform && \
ansible-playbook level2/level2.yaml \
  -e base_templates_folder=/tf/caf/templates/platform \
  -e config_folder=/tf/caf/enterprise_scale/contoso/platform \
  -e scenario=contoso \
  -e model=demo

```