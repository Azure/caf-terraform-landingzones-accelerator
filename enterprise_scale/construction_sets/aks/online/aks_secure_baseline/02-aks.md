# Deploy AKS Applications

## Deploy cluster baseline settings via Flux

Make sure the current folder is "*enterprise_scale/construction_sets/aks*"

  ```bash
 # Login to the AKS if in ESLZ
  echo $(terraform output -json | jq -r .aks_clusters_kubeconfig.value.cluster_re1.aks_kubeconfig_cmd) | bash
  
  # Otherwise use this to login
  echo $(terraform output -json | jq -r .aks_clusters_kubeconfig.value.cluster_re1.aks_kubeconfig_admin_cmd) | bash

  # Make sure logged in
  kubectl get pods -A
  ```

Please review the Baseline components that are deployed at [cluster-baseline-settings](./cluster-baseline-settings):

- AAD Pod Identity
- AKV Secret Store CSI Driver
- Ingress Network Policy
- Kured

  ```bash
  # Deploy Baseline components via Flux
  kubectl apply -f online/aks_secure_baseline/cluster-baseline-settings/flux.yaml
  # Watch Flux deployment, Ctrl-C to quit
  kubectl get po -n cluster-baseline-settings -w
  ```

Flux will pull from [cluster-baseline-settings](./cluster-baseline-settings) and synchronize the folder to AKS.
If there is a need to change the folder to your own folk, please modify [flux.yaml](cluster-baseline-settings/flux.yaml) --git-url args

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

2. Update Traefik config to pin IP in Aks-ingress Subnet:
    ```bash
    # Get the ingress controller subnet name
    ingress_subnet_name=$(terraform output -json | jq -r .vnets.value.vnet_aks_re1.subnets.aks_ingress.name)
    # Update the traefik yaml
    # Mac UNIX: 
    sed -i "" "s/azure-load-balancer-internal-subnet:.*/azure-load-balancer-internal-subnet:\ ${ingress_subnet_name}/g" online/aks_secure_baseline/workloads/baseline/traefik.yaml

    # Linux:
    sed -i "s/azure-load-balancer-internal-subnet:.*/azure-load-balancer-internal-subnet:\ ${ingress_subnet_name}/g" online/aks_secure_baseline/workloads/baseline/traefik.yaml
    ```

3. Deploy Traefik & ASP.net sample appplication
    ```bash
    kubectl apply -f online/aks_secure_baseline/workloads/baseline
    # It takes 2-3 mins to deploy Traefik & the sample app. Watch all pods to be provision with:
    kubectl get pods -n a0008 -w
    # Ensure sample app ingress has IP assigned
    kubectl get ingress -n a0008
    # This website will be available at the public domain below

    terraform output -json | jq -r '"https://" + (.domain_name_registrations.value.random_domain.dns_domain_registration_name)'
    ```

4. You can now test the application from a browser. After couple of the minutes the application gateway health check warning should disappear

## Destroy resources

When finished, please destroy all deployments with:

```bash
# Delete sample application, this contains PodDisruptionBudget that will block Terraform destroy
kubectl delete -f online/aks_secure_baseline/workloads/baseline

# (When needed) Destroy the resources
eval terraform destroy ${parameter_files}

# or if you are facing destroy issues
eval terraform destroy \
  ${parameter_files} \
  -refresh=false
```
