#!/bin/bash

storage_name=$(az storage account list --query "[?tags.tfstate=='level0' && tags.launchpad=='launchpad']" -o json | jq -r .[0].name)

if [ "${storage_name}" = "null" ]; then
    git clone https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public
    /tf/rover/rover.sh -lz /tf/caf/public/caf_launchpad -a apply -launchpad -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/configuration/launchpad
    storage_name=$(az storage account list --query "[?tags.tfstate=='level0' && tags.launchpad=='launchpad']" -o json | jq -r .[0].name)
fi

export LAUNCHPAD_PREFIX=${storage_name%stlevel*}

echo "LAUNCHPAD_PREFIX":$LAUNCHPAD_PREFIX

