# Cloud Adoption Framework landing zones for Terraform - Starter template

## Generate the configuration files

```bash
cd /tf/caf/templates/platform

# Generate the contoso demo files (only this scenario is supported at the moment. More to come)
ansible-playbook e2e.yaml -e scenario=contoso -e model=demo

```

## Deploy the stack using symphony job

```bash

## Prerequisites

```bash
branch=eslz.0.3.3
cd /tf/caf/
git clone --branch ${branch} https://github.com/Azure/caf-terraform-landingzones.git landingzones

# If you are planning to submit PR you can clone the a forked version instead
git clone --branch ${branch} git@github.com:Azure/caf-terraform-landingzones.git landingzones

# Or refresh an existing clone
cd /tf/caf/landingzones
git fetch origin
git checkout ${branch}
git status

cd /tf/caf/
git pull


```


# Only launchpad

 rover deploy \
  apply \
  -sc /tf/caf/configuration/contoso/platform/demo/pipelines/symphony_e2e.yaml \
  -b /tf/caf/ \
  -env sandpit

```

## Individual levels deployments

```bash

# Only launchpad

 rover deploy \
  plan \
  -sc /tf/caf/configuration/contoso/platform/demo/pipelines/symphony_e2e.yaml \
  -b /tf/caf \
  -env sandpit \
  -ct launchpad \
  -level level0

# Only launchpad

 rover deploy \
  plan \
  -sc /tf/caf/configuration/contoso/platform/demo/pipelines/symphony_e2e.yaml \
  -b /tf/caf \
  -env sandpit \
  -ct launchpad \
  -level level0

```