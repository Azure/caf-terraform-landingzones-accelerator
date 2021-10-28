
# Generate the terraform configuration files

To execute this step you need to login with on of the CAF maintainers:
{% for maintainer in config.platform_identity.caf_platform_maintainers %}
  - {{ maintainer }}
{% endfor %}

```bash
rover login -t {{ config.platform_identity.tenant_name }}

rover ignite \
  --playbook /tf/caf/starter/templates/platform/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e config_folder={{ config_folder }} \
  -e config_folder_asvm={{ config_folder_asvm }} \
