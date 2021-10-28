# Deploy AKS Applications

## Deploy cluster baseline settings via Flux

Flux V2 and [infrastructure configurations](../../cluster-baseline-settings) are installed automatically by the Terraform module.

If you are following the manual approach, then perform the instructions below:

Make sure the current folder is "*enterprise_scale/construction_sets/aks/online/aks_secure_baseline/standalone*"
If not use the below command:
  ```bash
  # Go to the AKS construction set standalone folder
  cd caf-terraform-landingzones-starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/standalone
  # If opened in containter in VSCode
  cd /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/standalone
  ```

  ```bash
  # Login to the AKS in current user
  echo $(terraform output -json | jq -r .aks_clusters_kubeconfig.value.cluster_re1.aks_kubeconfig_cmd) | bash

  # If there is lack of RBAC permission in your user role, login with Admin (not recommended for Production)
  echo $(terraform output -json | jq -r .aks_clusters_kubeconfig.value.cluster_re1.aks_kubeconfig_admin_cmd) | bash

  # Make sure logged in
  kubectl get pods -A
  ```
```

Please review the Baseline components that are deployed at [cluster-baseline-settings](../../cluster-baseline-settings):

- AAD Pod Identity
- AKV Secret Store CSI Driver
- Ingress Network Policy
- Kured

  ```bash
  # Watch configurations deployment, Ctrl-C to quit
  kubectl get pod -n cluster-baseline-settings -w
  ```

Flux pulls yamls from [cluster-baseline-settings](../../cluster-baseline-settings) and applies them to the cluster.
If there is a need to change the folder to your own, please modify [cluster-baseline-settings.yaml](../flux/cluster-baseline-settings.yaml)

## Deploy sample workload

1. Get the AKS Ingress Controller Managed Identity details.

    ```bash
    export TRAEFIK_USER_ASSIGNED_IDENTITY_RESOURCE_ID=$(terraform output -json | jq -r .managed_identities.value.ingress.id)
    export TRAEFIK_USER_ASSIGNED_IDENTITY_CLIENT_ID=$(terraform output -json | jq -r .managed_identities.value.ingress.client_id)
    ```

1. Ensure Flux has created the following namespace.

    ```bash
    # press Ctrl-C once you receive a successful response
    kubectl get ns a0008
    ```

1. Create Traefik's Azure Managed Identity binding.

   > Create the Traefik Azure Identity and the Azure Identity Binding to let Azure Active Directory Pod Identity to get tokens on behalf of the Traefik's User Assigned Identity and later on assign them to the Traefik's pod.

    ```yaml
    cat <<EOF | kubectl create -f -
    apiVersion: aadpodidentity.k8s.io/v1
    kind: AzureIdentity
    metadata:
        name: podmi-ingress-controller-identity
        namespace: a0008
    spec:
        type: 0
        resourceID: $TRAEFIK_USER_ASSIGNED_IDENTITY_RESOURCE_ID
        clientID: $TRAEFIK_USER_ASSIGNED_IDENTITY_CLIENT_ID
    ---
    apiVersion: aadpodidentity.k8s.io/v1
    kind: AzureIdentityBinding
    metadata:
        name: podmi-ingress-controller-binding
        namespace: a0008
    spec:
        azureIdentity: podmi-ingress-controller-identity
        selector: podmi-ingress-controller
    EOF
    ```

1. Create the Traefik's Secret Provider Class resource.

   > The Ingress Controller will be exposing the wildcard TLS certificate you created in a prior step. It uses the Azure Key Vault CSI Provider to mount the certificate which is managed and stored in Azure Key Vault. Once mounted, Traefik can use it.
   >
   > Create a `SecretProviderClass` resource with with your Azure Key Vault parameters for the [Azure Key Vault Provider for Secrets Store CSI driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure).

    ```bash
    KEYVAULT_NAME=$(terraform output -json | jq -r .keyvaults.value.secrets.name)
    TENANTID_AZURERBAC=$(az account show --query tenantId -o tsv)
    ```
    ```yaml
    cat <<EOF | kubectl apply -f -
    apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
    kind: SecretProviderClass
    metadata:
      name: aks-ingress-contoso-com-tls-secret-csi-akv
      namespace: a0008
    spec:
      provider: azure
      parameters:
        usePodIdentity: "true"
        keyvaultName: $KEYVAULT_NAME
        objects:  |
          array:
            - |
              objectName: wildcard-ingress
              objectAlias: tls.crt
              objectType: cert
            - |
              objectName: wildcard-ingress
              objectAlias: tls.key
              objectType: secret
        tenantId: $TENANTID_AZURERBAC
    EOF
    ```

2. Update Traefik config to pin IP in Aks-ingress Subnet:
    ```bash
    # Get the ingress controller subnet name
    ingress_subnet_name=$(terraform output -json | jq -r .vnets.value.vnet_aks_re1.subnets.aks_ingress.name)
    # Update the traefik yaml
    # Mac UNIX:
    sed -i "" "s/azure-load-balancer-internal-subnet:.*/azure-load-balancer-internal-subnet:\ ${ingress_subnet_name}/g" ../workloads/baseline/traefik.yaml

    # Linux:
    sed -i "s/azure-load-balancer-internal-subnet:.*/azure-load-balancer-internal-subnet:\ ${ingress_subnet_name}/g" ../workloads/baseline/traefik.yaml
    ```

3. Deploy Traefik & ASP.net sample appplication

    ```bash
    kubectl apply -f ../workloads/baseline
    # It takes 2-3 mins to deploy Traefik & the sample app. Watch all pods to be provision with, press Ctrl + C to exit from watch:
    kubectl get pods -n a0008 -w
    # Ensure sample app ingress has IP assigned
    kubectl get ingress -n a0008
    # This website will be available at the public domain below

    terraform output -json | jq -r '"https://" + (.domain_name_registrations.value.random_domain.dns_domain_registration_name)'
    ```

4. You can now test the application from a browser. After couple of the minutes the application gateway health check warning should disappear


## Test

You may use [automated integration tests](../../test) to test the deployed infrastructure.

You are done with deployment of AKS environment, next step is to deploy the application and reference components.

```bash
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
export PREFIX=$(terraform output -json | jq -r '.global_settings.value.prefixes[0]')
export ENVIRONMENT=sandpit # replace if another Environment was set in the rover, default is sandpit
echo $(terraform output -json | jq -r .aks_clusters_kubeconfig.value.cluster_re1.aks_kubeconfig_admin_cmd) | bash

# Go to the Test folder
cd ../test

go mod tidy

# If there is ERROR: AADSTS70043: The refresh token has expired or is invalid due to sign-in frequency checks by conditional access
# Perform az login again

go test -v  shared_services/shared_services_test.go
go test -v  aks/aks_test.go
go test -v  flux/flux_test.go
```

## Destroy resources

When finished, please destroy all deployments with:

```bash
# Go to the Standalone folder
cd ../standalone
# Delete sample application, this contains PodDisruptionBudget that will block Terraform destroy
kubectl delete -f ../workloads/baseline

# remove to bypass the "context deadline exceeded" error from flux provider
terraform state rm 'module.flux_addon'
# (When needed) Destroy the resources
eval terraform destroy ${parameter_files}

# or if you are facing destroy issues
eval terraform destroy \
  ${parameter_files} \
  -refresh=false
```
