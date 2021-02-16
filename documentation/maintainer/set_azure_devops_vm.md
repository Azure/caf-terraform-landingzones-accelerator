


```bash

# Install the Ansible libraries
sudo pip3 install winrm packaging msrest msrestazure ansible[azure]

ansible-galaxy collection install \
  azure.azcollection \
  ansible.windows \
  community.general --force

password='set your complex password'

cd documentation/maintainer
ansible-playbook ./set_azure_devops_vm.yaml \
  -e "ansible_winrm_password=${password}" \
  -e "admin_password=${password}"

```

