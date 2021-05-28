# ArgoCD

Deploys Applications on top of an AKS Landing zone

## Prerequisite

It is required to have an existing AKS Landing zone (level3) already provisioned prior to deploy Application Landing zone (level4) on top of.

## 1. Rover login, Environment & example set

Ensure the below is set prior to apply or destroy.

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment is needed to be defined, otherwise the below LZs will land into sandpit which someone else is working on
export environment=[YOUR_ENVIRONMENT]
```

## 2. Apply Landing zone

Please make sure to change the cluster_key in /tf/caf/examples/applications/{app_example}/configuration.tfvars to choose the cluster to deploy this Application LZ to.

```bash
application="argocd"
# Landingzone key hosting the AKS cluster
landingzone_key="cluster_aks"
# Key of the cluster to deploy the application
cluster_key="cluster_re1"

rover -lz /tf/caf/public/landingzones/caf_solutions/add-ons/aks_applications/ \
  -tfstate ${application}1.tfstate \
  -var-folder /tf/caf/reference_implementations/azure_kubernetes_services/applications/${application} \
  -var tags={application=\"${application}\"} \
  -level level4 \
  -a [plan|apply|destroy]
```

More details about this landing zone can also be found in the landing zone folder and its blueprints sub-folders.

## Contribute

Pull requests are welcome to evolve the framework and integrate new features.
