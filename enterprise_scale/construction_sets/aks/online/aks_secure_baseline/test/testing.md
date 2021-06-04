# Integration testing of Enterprise-Scale AKS Construction Set with Terratest

There is a set of sample integration tests that cover some parts of this constructions set. These tests are used by IaC pipeline after deploying each part.

In order to run tests locally you must have [GoLang installed](https://golang.org/doc/install) as Terratest is based on GoLang.

Each test for each part reads expected values from ExpectedValues.yaml file in a corresponding test folder.

To run all tests perform the following steps:

   ```bash
   # Go to the folder with tests
   cd caf-terraform-landingzones-starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/test

   export ARM_SUBSCRIPTION_ID=<Subscription ID>
   export PREFIX=<prefix of provisioned by Terraform  resources>
   export ENVIRONMENT=<e.g. snadpit>
   
   # Testing of the launchpad makes sense if the resources have been provisioned with the rover,
   # otherwise comment the following line  
   ./run_test.sh launchpad/launchpad_test.go

   ./run_test.sh shared_services/shared_services_test.go
   ./run_test.sh aks/aks_test.go

   export KUBECONFIGPATH=<path to kubeconfig file>
   ./run_test.sh flux/flux_test.go
```




