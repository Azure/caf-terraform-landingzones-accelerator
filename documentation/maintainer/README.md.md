
Execute the following command from the cloud shell.

The installation time is 20 minutes.

```bash

# By default the ansible playbook deploys a Standard D8ds_v4 (8 vcpus, 32 GiB memory) to get the maximum speed and reduce the time to way for terraform to execute.

# If you want to set a different family type you can add the -e vm_size=Standard_D2ds_v4  (2 vcpu, 8 GiB)
# More details - https://docs.microsoft.com/en-us/azure/virtual-machines/ddv4-ddsv4-series#ddsv4-series
# Or select another vm supporting Hyper-threading https://docs.microsoft.com/en-us/azure/virtual-machines/acu

git clone -b AL-contoso https://github.com/Azure/caf-terraform-landingzones-starter.git

password='set your complex password'

cd caf-terraform-landingzones-starter/documentation/maintainer

# Adjust the subscription if needed
# az account set -s subscription_id

export AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv)

ansible-playbook ./set_azure_devops_vm.yaml \
  -e ansible_winrm_password="${password}" \
  -e admin_password="${password}" \
  -e location=eastus

```

