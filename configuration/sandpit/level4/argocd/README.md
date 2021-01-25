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

rover -lz /tf/caf/applications \
  -tfstate ${application}1.tfstate \
  -var-folder /tf/caf/examples/applications/${application} \
  -var tags={application=\"${application}\"} \
  -level level4 \
  -a apply
```

## 3. Destroy Landing zone

Have fun playing with the landing zone an once you are done, you can simply delete the deployment using:

```bash
application=argocd
# Landingzone key hosting the AKS cluster
landingzone_key="cluster_aks"
# Key of the cluster to deploy the application
cluster_key="cluster_re1"

rover -lz /tf/caf/applications \
  -tfstate ${landingzone_key}_${cluster_key}_${application}.tfstate \
  -var-folder /tf/caf/examples/applications/${application} \
  -var tags={application=\"${application}\"} \
  -var landingzone_key=${landingzone_key} \
  -var cluster_key=${cluster_key} \
  -level level4 \
  -a destroy -auto-approve
```

More details about this landing zone can also be found in the landing zone folder and its blueprints sub-folders.

## Contribute

Pull requests are welcome to evolve the framework and integrate new features.
