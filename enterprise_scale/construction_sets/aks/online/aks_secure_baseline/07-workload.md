

1. Get the AKS Ingress Controller Managed Identity details.

   ```bash
    export TRAEFIK_USER_ASSIGNED_IDENTITY_RESOURCE_ID=$(terraform output -json | jq -r .managed_identities.value.ingress.id)
    export TRAEFIK_USER_ASSIGNED_IDENTITY_CLIENT_ID=$(terraform output -json | jq -r .managed_identities.value.ingress.client_id)
    ```

1. Ensure Flux has created the following namespace.

   ```bash
   # press Ctrl-C once you receive a successful response
   kubectl get ns a0008 -w
   ```

1. Create Traefik's Azure Managed Identity binding.

   > Create the Traefik Azure Identity and the Azure Identity Binding to let Azure Active Directory Pod Identity to get tokens on behalf of the Traefik's User Assigned Identity and later on assign them to the Traefik's pod.

   ```bash
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