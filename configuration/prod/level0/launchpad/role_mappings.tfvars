
#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#

role_mapping = {
  built_in_role_mapping = {
    management_group = {
      root = {
        "User Access Administrator" = {
          azuread_service_principals = {
            keys = ["level0"]
          }
        }
        "Management Group Contributor" = {
          azuread_service_principals = {
            keys = ["eslz"]
          }
        }
        "Owner" = {
          azuread_service_principals = {
            keys = ["eslz"]
          }
        }
      }
    }
    subscriptions = {
      logged_in_subscription = {
        "Owner" = {
          azuread_groups = {
            keys = ["caf_launchpad_maintainer"]
          }
          azuread_service_principals = {
            keys = ["level0"]
          }
        }
      }
    }

    resource_groups = {
      level0 = {
        "Reader" = {
          azuread_service_principals = {
            keys = [
              "identity",
              "subscription_creation_platform"
            ]
          }
        }
      }
      level1 = {
        "Reader" = {
          azuread_groups = {
            keys = [
              "identity",
              "management"
            ]
          }
          azuread_service_principals = {
            keys = [
              "eslz",
              "subscription_creation_platform"
            ]
          }
        }
      }
      level2 = {
        "Reader" = {
          azuread_service_principals = {
            keys = [
              "connectivity",
              "management"
            ]
          }
        }
      }
    }

    storage_accounts = {
      level0 = {
        "Storage Blob Data Contributor" = {
          azuread_groups = {
            keys = ["caf_launchpad_maintainer"]
          }
          azuread_service_principals = {
            keys = ["level0"]
          }
        }

        "Storage Blob Data Reader" = {
          azuread_groups = {
            keys = [
              "identity",
              "management"
            ]
          }
          azuread_service_principals = {
            keys = [
              "eslz",
              "subscription_creation_platform"
            ]
          }
        }

      }

      level1 = {
        "Storage Blob Data Contributor" = {
          azuread_groups = {
            keys = [
              "caf_launchpad_maintainer",
              "identity",
              "management"
            ]
          }
          azuread_service_principals = {
            keys = [
              "eslz",
              "subscription_creation_platform"
            ]
          }
        }

        "Storage Blob Data Reader" = {
          azuread_service_principals = {
            keys = ["connectivity"]
          }
        }

      }

      level2 = {
        "Storage Blob Data Contributor" = {
          azuread_groups = {
            keys = ["caf_launchpad_maintainer"]
          }
          azuread_service_principals = {
            keys = [
              "connectivity",
              "management"
            ]
          }
        }
      }
    }
  }
}
