landingzone = {
  backend_type        = "azurerm"
  level               = "level4"
  key                 = "argocd"
  global_settings_key = "cluster_aks" # Update accordingly based on the configuration file of your AKS cluster landingzone.key
  tfstates = {
    cluster_aks = {
      level   = "lower"                   # Update accordingly based on the configuration file of your AKS cluster landingzone.key
      tfstate = "landingzone_aks.tfstate" # Update accordingly based on the value you used to deploy you aks cluster with the rover -tfstate <value>
    }
  }
}

cluster_re1_key = "cluster_re1"
cluster_re2_key = "cluster_re2"

namespaces = {
  argocd = {
    name = "argocd"
  }
}

helm_charts = {
  argocd = {
    name       = "argo"
    repository = "https://argoproj.github.io/argo-helm"
    chart      = "argo-cd"
    namespace  = "argocd"
  }
}
