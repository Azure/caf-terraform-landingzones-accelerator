# Integration testing of Enterprise-Scale AKS Construction Set with Terratest

There is a set of [sample integration tests](../../test) that cover some parts of this constructions set. These tests are used by IaC pipeline after deploying each part.

In order to run tests locally you must have [GoLang installed](https://golang.org/doc/install) as Terratest is based on GoLang.

Each test for each part reads expected values from ExpectedValues.yaml file in a corresponding test folder. 

To run all tests perform the following steps:

```bash
   # Go to the folder with tests
   cd caf-terraform-landingzones-starter/enterprise_scale/construction_sets/aks/test

   export ARM_SUBSCRIPTION_ID=<Subscription ID>
   export LAUNCHPAD_PREFIX=<prefix of provisioned by Terraform launchpad resources>
   export ENVIRONMENT=<e.g. snadpit>
   ./run_test.sh level0_launchpad/launchpad_test.go
   
   export PREFIX=<prefix of provisioned by Terraform  resources>
   ./run_test.sh level1_foundation/level1_foundation_test.go
   ./run_test.sh level2_shared_services/level2_shared_services_test.go
   ./run_test.sh level3_aks/level3_aks_test.go

   export KUBECONFIGPATH=<path to kubeconfig file>
   ./run_test.sh level4_flux/level4_flux_test.go
```




