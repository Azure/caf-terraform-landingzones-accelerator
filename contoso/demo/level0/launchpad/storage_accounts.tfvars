
storage_accounts = {
  level0 = {
    name                     = "l0"
    resource_group_key       = "level0"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      ## Those tags must never be changed after being set as they are used by the rover to locate the launchpad and the tfstates.
      # Only adjust the environment value at creation time
      tfstate         = "level0"
      environment     = "sandpit"
      launchpad       = "launchpad"
      caf_environment = "sandpit"
      caf_launchpad   = "launchpad"
      caf_tfstate     = "level0"
      ##
    }
    containers = {
      # It is recommended to keep the default container name to tfstate
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level1 = {
    name                     = "l1"
    resource_group_key       = "level1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate         = "level1"
      environment     = "sandpit"
      launchpad       = "launchpad"
      caf_environment = "sandpit"
      caf_launchpad   = "launchpad"
      caf_tfstate     = "level1"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
      credentials = {
        name = "credentials"
      }
      devops = {
        name = "devops"
      }
    }
  }

  level2 = {
    name                     = "l2"
    resource_group_key       = "level2"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate         = "level2"
      environment     = "sandpit"
      launchpad       = "launchpad"
      caf_environment = "sandpit"
      caf_launchpad   = "launchpad"
      caf_tfstate     = "level2"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level3 = {
    name                     = "l3"
    resource_group_key       = "level3"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate         = "level3"
      environment     = "sandpit"
      launchpad       = "launchpad"
      caf_environment = "sandpit"
      caf_launchpad   = "launchpad"
      caf_tfstate     = "level3"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level4 = {
    name                     = "l4"
    resource_group_key       = "level4"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate         = "level4"
      environment     = "sandpit"
      launchpad       = "launchpad"
      caf_environment = "sandpit"
      caf_launchpad   = "launchpad"
      caf_tfstate     = "level4"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

}