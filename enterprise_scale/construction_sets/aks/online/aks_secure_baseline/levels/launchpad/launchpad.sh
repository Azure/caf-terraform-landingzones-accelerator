#!/bin/bash

id=$(az storage account list --query "[?tags.tfstate=='level0' && tags.launchpad=='launchpad']" -o json | jq -r .[0].id)

if [ "${id}" == "null" ]; then 
    git clone https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public
    /tf/rover/rover.sh -lz /tf/caf/public/landingzones/caf_launchpad -a apply -launchpad -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/levels/launchpad    
fi  

echo "STORAGE ID":${id}
