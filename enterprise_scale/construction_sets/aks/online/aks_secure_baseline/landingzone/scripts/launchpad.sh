#!/bin/bash

export ACTION=${ACTION:="apply"} 
export TF_VAR_environment=${TF_VAR_environment:="sandpit"}

if [ -d "/tf/caf/landingzones" ] 
then
    echo "/tf/caf/landingzones already exists"
else
    git clone --branch azure_devops_v1 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
fi


# /tf/rover/rover.sh -lz /tf/caf/public/caf_launchpad -a apply -launchpad -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/configuration/launchpad
if [ $(echo $ACTION | awk '{print $1;}') != "output" ];
then
    /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_launchpad \
    -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/level0/launchpad \
        -launchpad \
        -level level0 \
        -a ${ACTION}
else 
    /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_launchpad \
        -launchpad \
        -level level0 \
        -a ${ACTION}
fi
