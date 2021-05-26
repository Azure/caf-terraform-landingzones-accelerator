#!/bin/bash

# Usage:
#
# deploy_part_with_rover.sh PART_NAME
#
# e.g:
# deploy_part_with_rover.sh 2_networking

PART_NAME=$1

baseline_folder_name=online/aks_secure_baseline
config_folder_name=$baseline_folder_name/configuration/
parameters_file_name=$baseline_folder_name/parts/$PART_NAME/parameters

cat $parameters_file_name
[ -f $(pwd)/$parameters_file_name ] || { printf "File %s doesn't exist\n" $parameters_file_name; exit 1; }

parameters=$(cat $parameters_file_name | grep .tfvars | sed -e 's#^#-var-file '$config_folder_name'#' | xargs)

printf "parameters : %s\n" $parameters

lz=$(pwd)



/tf/rover/rover.sh -lz $lz \
     -a apply \
     -parallelism 30 \
     "$parameters -var override_prefix=$PREFIX"


