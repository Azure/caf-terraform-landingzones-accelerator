

# Kubernetes
resource "kubernetes_namespace" "flux-system" {
  count = var.flux_namespace == "" ? 0 : 1 
  metadata {
    name = var.flux_namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

resource "kubernetes_secret" "fluxauth" {
  count = var.flux_namespace == "" ? 0 : 1
  metadata {
    name = var.flux_auth_secret
    namespace = var.flux_namespace
  }
  data = {
    username = var.github_owner
    password = var.github_token
  }

  type = "kubernetes.io/basic-auth"
}



resource "kubectl_manifest" "install" {
  for_each   = var.flux_namespace == "" ? {} : { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux-system]
  yaml_body  = each.value
}

resource "kubectl_manifest" "sync" {
  for_each   = var.flux_namespace == "" ? {} : { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
  depends_on = [kubernetes_namespace.flux-system]
  yaml_body  = each.value
}
