# Integration testing of Enterprise-Scale AKS Construction Set with Terratest

There is a set of sample integration tests that cover some parts of this constructions set. These tests are used by IaC pipeline after deploying each part.

In order to run tests locally you must have [GoLang installed](https://golang.org/doc/install) as Terratest is based on GoLang.

Each test for each part reads expected values from ExpectedValues.yaml file in a corresponding test folder.

[Landing zone test](../landingzone/docs/aks.md#test)

[Standalone test](../standalone/docs/aks.md#test)
