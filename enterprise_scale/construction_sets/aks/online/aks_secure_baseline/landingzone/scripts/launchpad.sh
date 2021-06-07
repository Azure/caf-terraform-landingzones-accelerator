#!/bin/bash

storage_name=$(az storage account list --query "[?tags.tfstate=='level0' && tags.launchpad=='launchpad']" -o json | jq -r .[0].name)
export TF_VAR_environment=${TF_VAR_environment:="sandpit"}


if [ "${storage_name}" = "null" ]; then
    if [ -d "/tf/caf/landingzones" ] 
    then
        echo "/tf/caf/landingzones already exists"
    else
        git clone --branch azure_devops_v1 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
    fi


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

