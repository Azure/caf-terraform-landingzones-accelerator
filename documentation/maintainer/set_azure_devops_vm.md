
Execute the following command from the cloud shell.

The installation time is 20 minutes.

```bash

# By default the ansible playbook deploys a Standard D8as_v4 (8 vcpus, 32 GiB memory) to get the maximum speed and reduce the time to way for terraform to execute.

# If you want to set a different family type you can add the -e vm_size=Standard_D4s_v4

git clone https://github.com/Azure/caf-terraform-landingzones-starter.git

ansible-galaxy collection install \
  community.docker

password='set your complex password'

cd caf-terraform-landingzones-starter/documentation/maintainer

ansible-playbook ./set_azure_devops_vm.yaml \
  -e ansible_winrm_password="${password}" \
  -e admin_password="${password}"

```

