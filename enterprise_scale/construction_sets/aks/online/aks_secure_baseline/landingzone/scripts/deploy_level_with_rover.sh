#!/bin/bash

# Usage:
#
# deploy_level_with_rover.sh LEVEL_NAME LZ_NAME ADDON_NAME(optional)
#
# e.g:
# deploy_level_with_rover.sh level1 shared_services

LEVEL_NAME=$1
LZ_NAME=$2
ADDON_NAME=$3
export ACTION=${ACTION:="apply"} 
export TF_VAR_environment=${TF_VAR_environment:="sandpit"}


if [ -d "/tf/caf/landingzones" ] 
then
  echo "/tf/caf/landingzones already exists"
else
  git clone --branch azure_devops_v1 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones
fi

/tf/rover/rover.sh  \
  -lz /tf/caf/landingzones/caf_solution${ADDON_NAME} \
  -var-folder /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/landingzone/configuration/${LEVEL_NAME}/${LZ_NAME} \
  -tfstate ${LZ_NAME}.tfstate \
  -level ${LEVEL_NAME} \
  -a ${ACTION}
