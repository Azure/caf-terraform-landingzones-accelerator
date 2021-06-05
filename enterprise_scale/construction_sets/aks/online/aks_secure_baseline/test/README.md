# Integration testing of Enterprise-Scale AKS Construction Set with Terratest

There is a set of sample integration tests that cover some parts of this constructions set. These tests are used by IaC pipeline after deploying each part.

In order to run tests locally you must have [GoLang installed](https://golang.org/doc/install) as Terratest is based on GoLang.

Each test for each part reads expected values from ExpectedValues.yaml file in a corresponding test folder.

To run all tests perform the following steps:

   ```bash
   # Go to the folder with tests
   cd caf-terraform-landingzones-starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/test
   # If opened in container in VSCode
   cd /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/test
   ```

   ## Landing zone
   ```bash
   export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
   export PREFIX=$(terraform output -json | jq -r '.global_settings.value.prefixes[0]')
   export ENVIRONMENT=sandpit # replace if another Environment was set in the rover, default is sandpit

   go mod tidy
   
   # Testing of the launchpad makes sense if the resources have been provisioned with the rover,
   # otherwise comment the following line  
   go test -v  launchpad/launchpad_test.go
   go test -v  shared_services/shared_services_test.go
   go test -v  aks/aks_test.go
   ```

   ## Standalone
   ```bash

   export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
   export PREFIX=$(terraform output -json | jq -r '.global_settings.value.prefixes[0]')
   export ENVIRONMENT=sandpit # replace if another Environment was set in the rover, default is sandpit

   go mod tidy
   
   go test -v  shared_services/shared_services_test.go
   go test -v  aks/aks_test.go

   echo $(terraform output -json | jq -r .aks_clusters_kubeconfig.value.cluster_re1.aks_kubeconfig_admin_cmd) | bash
   go test -v  flux/flux_test.go
   ```




