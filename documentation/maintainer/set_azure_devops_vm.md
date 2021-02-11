


```bash

# Install the Ansible libraries
sudo pip3 install winrm packaging msrest msrestazure
pip3 install ansible[azure]
ansible-galaxy collection install ansible.windows --force
ansible-galaxy collection install azure.azcollection --force

password="set your complex password"

cd documentation/maintainer
ansible-playbook ./set_azure_devops_vm.yaml \
  -e "ansible_winrm_password=${password}" \
  -e "admin_password=${password}"

```

