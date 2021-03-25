landingzone = {
  backend_type        = "azurerm"
  level               = "level4"
  key                 = "flux"
  global_settings_key = "cluster_aks" # Update accordingly based on the configuration file of your AKS cluster landingzone.key
  tfstates = {
    cluster_aks = {
      level   = "lower"                   # Update accordingly based on the configuration file of your AKS cluster landingzone.key
      tfstate = "landingzone_aks.tfstate" # Update accordingly based on the value you used to deploy you aks cluster with the rover -tfstate <value>
    }
  }
}

cluster_re1_key = "cluster_re1"
# cluster_re2_key = "cluster_re2"


namespaces = {
  fluxcd = {
    name = "fluxcd"
    annotations = {
      name = "flux-annotation"
    }
    labels = {
      mylabel = "flux-value"
    }
  }
}

helm_charts = {
  # dapr = {
  #   name = "dapr"
  #   repository = "https://daprio.azurecr.io/helm/v1/repo"
  #   chart      = "dapr"
  #   namespace  = "default"
  # }
  flux = {
    name       = "flux"
    repository = "https://charts.fluxcd.io"
    chart      = "flux"
    namespace  = "fluxcd"
    sets = {
      "git.url" = "git@github.com:hieumoscow/flux-get-started"
    }
  }
  flux_helm_operator = {
    name       = "helm-operator"
    repository = "https://charts.fluxcd.io"
    chart      = "helm-operator"
    namespace  = "fluxcd"
    sets = {
      "git.ssh.secretName" = "flux-git-deploy"
      "helm.versions"      = "v3"
    }
  }
}