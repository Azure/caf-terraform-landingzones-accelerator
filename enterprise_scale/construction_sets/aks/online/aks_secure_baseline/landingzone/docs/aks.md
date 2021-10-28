# Deploy AKS Applications

## Deploy cluster baseline settings via Flux

Flux V2 and [infrastructure configurations](../../cluster-baseline-settings) are installed automatically by the Terraform module.

If you are following the manual approach, then perform the instructions below:

Make sure the current folder is "*enterprise_scale/construction_sets/aks/online/aks_secure_baseline/*"
If not use the below command:

  ```bash
  # Go to the AKS construction set folder
  cd caf-terraform-landingzones-starter/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/
  # If opened in containter in VSCode
  cd /tf/caf/enterprise_scale/construction_sets/aks/online/aks_secure_baseline/
  ```

  ```bash
  output_file=/tf/caf/output.json

  rover \
  -lz /tf/caf/landingzones/caf_solution \
  -tfstate aks.tfstate \
  -env ${caf_env} \
  -level level2 \
  -a output -json -o $output_file

  # To find a path to an output key
  output_key="aks_kubeconfig_cmd"
  cat $output_file | jq -c 'paths | select(.[-1] == "'"$output_key"'")'
  # Login to the AKS in current user
  cat $output_file | jq -r .objects.value.aks.aks_clusters.cluster_re1.aks_kubeconfig_cmd | bash

  # If there is lack of RBAC permission in your user role, login with Admin (not recommended for Production)
  cat $output_file | jq -r .objects.value.aks.aks_clusters.cluster_re1.aks_kubeconfig_admin_cmd | bash

  # Make sure logged in
  kubectl get pods -A
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
    export TRAEFIK_USER_ASSIGNED_IDENTITY_RESOURCE_ID=$(cat $output_file | jq -r .objects.value.aks.managed_identities.ingress.id)
    export TRAEFIK_USER_ASSIGNED_IDENTITY_CLIENT_ID=$(cat $output_file | jq -r .objects.value.aks.managed_identities.ingress.client_id)
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
    KEYVAULT_NAME=$(cat $output_file | jq -r .objects.value.aks.keyvaults.secrets.name)
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
    output_file=/tf/caf/vnet-output.json
    
    rover \
    -lz /tf/caf/landingzones/caf_solution \
    -tfstate networking_spoke.tfstate \
    -env ${caf_env} \
    -level level1 \
    -a output -json -o $output_file
    
    ingress_subnet_name=$(cat $output_file | jq -r .objects.value.networking_spoke.vnets.vnet_aks_re1.subnets.aks_ingress.name)
    # Update the traefik yaml
    # Mac UNIX:
    sed -i "" "s/azure-load-balancer-internal-subnet:.*/azure-load-balancer-internal-subnet:\ ${ingress_subnet_name}/g" workloads/baseline/traefik.yaml

    # Linux:
    sed -i "s/azure-load-balancer-internal-subnet:.*/azure-load-balancer-internal-subnet:\ ${ingress_subnet_name}/g" workloads/baseline/traefik.yaml
    ```

3. Deploy Traefik & ASP.net sample appplication
    ```bash
    kubectl apply -f workloads/baseline
    # It takes 2-3 mins to deploy Traefik & the sample app. Watch all pods to be provision with:
    kubectl get pods -n a0008 -w
    # Ensure sample app ingress has IP assigned
    kubectl get ingress -n a0008
    # This website will be available at the public domain below
  
    output_file=/tf/caf/output.json
    cat $output_file | jq -r '"https://" + (.objects.value.aks.domain_name_registrations.random_domain.dns_domain_registration_name)'
    ```

4. You can now test the application from a browser. After couple of the minutes the application gateway health check warning should disappear



## Test


There is a set of sample integration tests that cover some parts of this constructions set


```bash
# Go to the Test folder
cd test

export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
output_file=/tf/caf/output.json
export PREFIX=$(cat $output_file | jq -r .objects.value.aks.global_settings.prefixes[0])
export ENVIRONMENT=${caf_env} # replace if another Environment was set in the rover, default is sandpit

go mod tidy

# If there is ERROR: AADSTS70043: The refresh token has expired or is invalid due to sign-in frequency checks by conditional access
# Perform rover login again

go test -v  launchpad/launchpad_test.go
go test -v  shared_services/shared_services_test.go
go test -v  aks/aks_test.go

go test -v  flux/flux_test.go
```

## Destroy resources

When finished, please destroy all deployments by following the below guide

:arrow_forward: [Destroy Landing zones](./destroy.md)