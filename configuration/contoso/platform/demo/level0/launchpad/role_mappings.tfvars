
#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#

role_mapping = {
  built_in_role_mapping = {
    management_group = {
      root = {
        "User Access Administrator" = {
          logged_in = {
            keys = ["user"]
          }
        }
        "Management Group Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
        "Owner" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
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
    storage_accounts = {
      level0 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
      level1 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
      level2 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
      level3 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
      level4 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
  }
}
