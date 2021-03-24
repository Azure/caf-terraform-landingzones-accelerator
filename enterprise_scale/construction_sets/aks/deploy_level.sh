#!/bin/bash

# Usage:
# 
# deploy_level.sh LEVEL_NAME
#
# e.g:
# deploy_level.sh 2_networking

LEVEL_NAME=$1

baseline_folder_name=online/aks_secure_baseline
config_folder_name=$baseline_folder_name/configuration/
parameters_file_name=$baseline_folder_name/levels/$LEVEL_NAME/parameters

cat $parameters_file_name
[ -f $(pwd)/$parameters_file_name ] || { printf "File %s doesn't exist\n" $parameters_file_name; exit 1; }

# parameters=$(cat $parameters_file_name | grep .tfvars | sed 's/.*/-var-file &/' | xargs)
parameters=$(cat $parameters_file_name | grep .tfvars | sed -e 's#^#-var-file '$config_folder_name'#' | xargs)

printf "parameters : %s\n" $parameters
eval terraform apply ${parameters}
