# Deployment of Enterprise-Scale AKS Construction Set

This reference implementation of AKS Secure Baseline Architecture within Enterprise Scale environment is built on CAF Terraform Landing zone framework composition.

The following components will be deployed by the Enterprise-Scale AKS Construction Set. You can review each component as described below:

![aks_enterprise_scale_lz](pictures/aks_enterprise_scale_lz.png)

| Components                                                                                              | Config files                                                 | Description|
|-----------------------------------------------------------|------------------------------------------------------------|------------------------------------------------------------|
| Global Settings |[global_settings.tfvars](configuration/global_settings.tfvars) | Primary Region setting. Changing this will redeploy the whole stack to another Region|
| Resource Groups | [resource_groups.tfvars](./configuration/resource_groups.tfvars)| Resource groups configs |
| Azure Kubernetes Service | [aks.tfvars](./configuration/aks.tfvars) | AKS addons, version, nodepool configs |
| Virtual networks | [networking.tfvars](./configuration/networking/networking.tfvars)| CIDRs, Subnets for AKS|

<br />

## Deployment

```bash
# Script to execute from bash shell

# Login to your Azure Active Directory tenant
az login -t {TENANTNID}

# Make sure you are using the right subscription
az account show -o table

# If you are not in the correct subscription, change it substituting SUBSCRIPTIONID with the proper subscription  id
az account set --subscription {SUBSCRIPTIONID}

# If you are running in Azure Cloud Shell, you need to run the following additional command:
export TF_VAR_logged_user_objectId=$(az ad signed-in-user show --query objectId -o tsv)

# Go to the AKS construction set folder 
cd caf-terraform-landingzones-starter/enterprise_scale/construction_sets/aks

configuration_folder=github_runner/configuration

# Define the configuration files to apply, all tfvars files within the above folder recursively
parameter_files=$(find $configuration_folder | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

# Load the CAF module and related providers
terraform init -upgrade

# Trigger the deployment of the resources
eval terraform apply ${parameter_files}

```

```bash
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.2.0 \
  --set installCRDs=true


helm repo add actions-runner-controller https://summerwind.github.io/actions-runner-controller
kubectl create namespace actions-runner-system
helm upgrade --install github-runner actions-runner-controller/actions-runner-controller -n actions-runner-system 

GITHUB_TOKEN=82f3e258deb691ff1950ff29ab3cded5e425b7a5
kubectl create secret generic controller-manager \
    -n actions-runner-system \
    --from-literal=github_token=${GITHUB_TOKEN}

APP_ID="103251"
INSTALLATION_ID="15111760"
PRIVATE_KEY="./github_runner/githubkey.pem"
kubectl create secret generic controller-manager \
    -n actions-runner-system \
    --from-literal=github_app_id=${APP_ID} \
    --from-literal=github_app_installation_id=${INSTALLATION_ID} \
    --from-file=github_app_private_key=${PRIVATE_KEY}
```