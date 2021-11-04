# Using rover ignite to generate your configuration stack files

The rover "ignite" is designed to help you build the stack of configuration files for Cloud Adoption Framework landing zones on Terraform.

This is still under development and the following example illustrate a mono subscription example, the multi subscription capabilities will be illustrated into another example.

## 1. Customize the configuration YAML files

There are two parts in the configuration files:

1. platform (mapping to CAF levels 0-2)
2. asvm (mapping to levels 3-4)

You must start by customizing the platform editing the ```/platform/configuration.caf.platform.yaml```

## 2. Generate the configuration Terraform files

```bash
cd /tf/caf/starter/templates/platform

rover ignite \
  --playbook /tf/caf/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/templates/platform \
  -e config_folder=/tf/caf/orgs/contoso/standalone/platform \
  -e config_folder_asvm=/tf/caf/orgs/contoso/standalone/asvm \
  -e boostrap_launchpad=false \
  -e deploy_subscriptions=false

```

## 3. Follow the instructions in the configuration folder

### Clone the landing zones binaries

```bash
git clone https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
```

### Deploy the launchpad

Go to the the ```/configuration``` folder for the respective environment and follow instruction dynamically generated for your environment.


### Deploy other services:

- management
- eslz
- connectivity