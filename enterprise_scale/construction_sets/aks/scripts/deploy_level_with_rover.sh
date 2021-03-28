#!/bin/bash

# Usage:
# 
# deploy_level_with_rover.sh LEVEL_NAME LEVEL
#
# e.g:
# deploy_level_with_rover.sh 2_networking level2

LEVEL_NAME=$1
LEVEL=$2 

baseline_folder_name=online/aks_secure_baseline
config_folder_name=$baseline_folder_name/configuration/
parameters_file_name=$baseline_folder_name/levels/$LEVEL_NAME/parameters

cat $parameters_file_name
[ -f $(pwd)/$parameters_file_name ] || { printf "File %s doesn't exist\n" $parameters_file_name; exit 1; }

parameters=$(cat $parameters_file_name | grep .tfvars | sed -e 's#^#-var-file '$config_folder_name'#' | xargs)

printf "parameters : %s\n" $parameters

lz=$(pwd)


# These parameters are not currently used. Everything goes to the same state storage.
# To make a nice level/storage separation module.tf should be decomposed into levels
# 
#  -level $LEVEL \
#  -tfstate  $LEVEL_NAME.tfstate \

/tf/rover/rover.sh -lz $lz \
     -a apply \
     -parallelism 30 \
     "$parameters -var test_prefix=$PREFIX"


