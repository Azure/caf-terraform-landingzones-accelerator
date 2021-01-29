
keyvaults = {

  # This keyvault is used to store the complex password created for the AKS breakglass admin user
  secrets = {
    name                = "secrets"
    resource_group_key  = "aks_re1"
    region              = "region1"
    sku_name            = "premium"
    soft_delete_enabled = false

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        certificate_permissions = ["Create", "Get", "List", "Delete", "Purge", "Recover"]
      }

      ingress_msi = {
        managed_identity_key = "ingress"
        secret_permissions = ["Get"]
        certificate_permissions = ["Get"]
      }
      
      keyvault_access_policies = {
        certificates = {
          apgw_keyvault_secrets = {
            managed_identity_key    = "apgw_keyvault_secrets"
            certificate_permissions = ["Get"]
            secret_permissions      = ["Get"]
          }
        }
      }
      
    }
  }
}


# 26s         Warning   FailedMount              pod/traefik-ingress-controller-844fcdd859-rlnv5            
# MountVolume.SetUp failed for volume "ssl-csi" : rpc error: code = Unknown desc = failed to mount secrets store objects 
# for pod a0008/traefik-ingress-controller-844fcdd859-rlnv5, err: rpc error: code = Unknown desc = failed to mount objects,
#  error: failed to get objectType:secret, objectName:wildcard-ingress, objectVersion:: keyvault.BaseClient#GetSecret: 
# Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="Forbidden" 
# Message="The user, group or application 'appid=6b449b85-8c06-420e-8410-30ac7b557570;oid=17617e21-dcdc-4925-ad83-70f4bdd854ae;iss=https://sts.windows.net/d6ad82f3-42af-4a15-ac1e-49e6c08f624e/' does not have secrets get permission on key vault 'rcgi-kv-secrets;location=southeastasia'. For help resolving this issue, please see https://go.microsoft.com/fwlink/?linkid=2125287" InnerError={"code":"ForbiddenByPolicy"}