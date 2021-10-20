
### Generate asvm for {{ asvm_folder }}

```bash
rover login -t {{ resources.platform_identity.tenant_name }}

export ARM_SKIP_PROVIDER_REGISTRATION=true

rover \
{% if resources.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ config_asvm.configuration_folders['asvm'].destination_base_path }}/{{ config_asvm.configuration_folders['asvm'].destination_relative_path }}/{{ level }}/{{ asvm_folder }}/subscription \
  -tfstate_subscription_id {{ resources.platform_core_setup.enterprise_scale.primary_subscription_details.subscription_id }} \
  -tfstate {{ config.tfstates["asvm"][asvm_folder].subscription.tfstate }} \
  --workspace {{ config.tfstates["asvm"][asvm_folder].workspace }} \
  -log-severity {{ resources.gitops.rover_log_error }} \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{  config.tfstates["asvm"][asvm_folder].subscription.tfstate }}.tfplan \
  -a plan

rover logout

```
Once you have executed the rover apply to create the subscription, you need to execute the rover ignite to generate the instructions for the next steps.

Note you need to logout and login as a caf_maintainer group member

```bash
rover login -t {{ resources.platform_identity.tenant_name }}

rover ignite \
  --playbook /tf/caf/starter/templates/asvm/ansible.yaml \
  -e base_templates_folder=/tf/caf/starter/templates/asvm \
  -e config_folder={{ config_folder }} \
  -e platform_config_folder={{ platform_config_folder }} \
  -e scenario={{ scenario }} 

```

# Next steps

When you have successfully created the subscription and re-executed the rover ignite you can move to the next step.

 [Deploy the platform resources in the subscription](../resources/readme.md)