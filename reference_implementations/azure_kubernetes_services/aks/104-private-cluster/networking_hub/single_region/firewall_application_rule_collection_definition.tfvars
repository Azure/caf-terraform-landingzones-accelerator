azurerm_firewall_application_rule_collection_definition = {
  aks = {
    name     = "aks"
    action   = "Allow"
    priority = 100
    ruleset = {
      aks = {
        name = "aks"
        source_addresses = [
          "*",
        ]
        fqdn_tags = [
          "AzureKubernetesService",
        ]
      },
    }
  }
  packages = {
    name     = "packages"
    action   = "Allow"
    priority = 110
    ruleset = {
      ubuntu = {
        name = "ubuntu"
        source_addresses = [
          "*",
        ]
        target_fqdns = [
          "security.ubuntu.com",
          "azure.archive.ubuntu.com",
          "archive.ubuntu.com",
          "changelogs.ubuntu.com",
        ]
        protocol = {
          https = {
            port = "443"
            type = "Https"
          }
          http = {
            port = "80"
            type = "Http"
          }
        }
      },
      docker = {
        name = "docker"
        source_addresses = [
          "*",
        ]
        target_fqdns = [
          "download.docker.com", # Docker
          "*.docker.io",         # Docker images
          "*.docker.com"         # Docker registry
        ]
        protocol = {
          http = {
            port = "443"
            type = "Https"
          }
        }
      },
      tools = {
        name = "tools"
        source_addresses = [
          "*",
        ]
        target_fqdns = [
          "packages.microsoft.com",
          "azurecliprod.blob.core.windows.net", # Azure cli
          "packages.cloud.google.com",          # kubectl
          "apt.kubernetes.io",                  # Ubuntu packages for kubectl
          "*.snapcraft.io",                     # snap to install kubectl
        ]
        protocol = {
          http = {
            port = "443"
            type = "Https"
          }
        }
      },
      github = {
        name = "github"
        source_addresses = [
          "*",
        ]
        target_fqdns = [
          "api.github.com",
          "github.com",
          "github-production-release-asset-2e65be.s3.amazonaws.com",
        ]
        protocol = {
          http = {
            port = "443"
            type = "Https"
          }
        }
      },
    }
  }
}