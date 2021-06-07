#!/bin/bash

storage_name=$(az storage account list --query "[?tags.tfstate=='level0' && tags.launchpad=='launchpad']" -o json | jq -r .[0].name)

if [ "${storage_name}" = "null" ]; then
     git clone --branch azure_devops_v1 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones


    # /tf/rover/rover.sh -lz /tf/caf/public/caf_launchpad -a apply -launchpad -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/configuration/launchpad
    /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_launchpad \
    -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level0/launchpad \
        -launchpad \
        -level level0 \
        -a apply \
        -var="random_length=0" -var="prefix=$PREFIX"


    storage_name=$(az storage account list --query "[?tags.tfstate=='level0' && tags.launchpad=='launchpad']" -o json | jq -r .[0].name)
fi

