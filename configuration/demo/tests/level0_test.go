// +build level0

package caf_tests

import (
	"context"
	"fmt"
	"strings"

	"github.com/aztfmod/terratest-helper-caf/state"
	"github.com/gruntwork-io/terratest/modules/azure"

	"testing"

	"github.com/stretchr/testify/assert"
)

func TestLaunchpadLandingZoneKey(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")

	landingZoneKey := tfState.GetLandingZoneKey()
	assert.Equal(t, "launchpad", landingZoneKey)
}

func TestLaunchpadResourceGroupIsExists(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		name := resourceGroup.GetName()
		exists := azure.ResourceGroupExists(t, name, tfState.SubscriptionID)
		assert.True(t, exists, fmt.Sprintf("Resource group (%s) does not exist", name))
	}
}

func TestLaunchpadResourceGroupIsExistsViaClient(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	client, _ := azure.GetResourceGroupClientE(tfState.SubscriptionID)
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		_, err := client.CheckExistence(context.Background(), rgName)
		assert.NoError(t, err, fmt.Sprintf("Resource group (%s) does not exist", rgName))
	}
}

func TestLaunchpadResourceGroupHasKeyVault(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		if !strings.Contains(rgName, "security") {
			keyVault, err := tfState.GetKeyVaultByResourceGroup(rgName)
			if err != nil {
				panic(err)
			}

			keyVaultName := keyVault.GetName()

			kv := azure.GetKeyVault(t, rgName, keyVaultName, tfState.SubscriptionID)
			assert.NotNil(t, kv, fmt.Sprintf("KeyVault (%s) does not exists", keyVaultName))
		}
	}
}

func TestLaunchpadKeyVaultHasTags(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		level := resourceGroup.GetLevel()

		if !strings.Contains(rgName, "security") {
			keyVault, err := tfState.GetKeyVaultByResourceGroup(rgName)
			if err != nil {
				panic(err)
			}

			keyVaultName := keyVault.GetName()
			kv := azure.GetKeyVault(t, rgName, keyVaultName, tfState.SubscriptionID)

			assert.NotNil(t, kv, fmt.Sprintf("KeyVault (%s) does not exists", keyVaultName))
			assert.Equal(t, tfState.Environment, *kv.Tags["environment"], "Environment Tag is not correct")
			assert.Equal(t, tfState.Key, *kv.Tags["landingzone"], "LandingZone Tag is not correct")
			assert.Equal(t, level, *kv.Tags["level"], "Level Tag is not correct")
			assert.Equal(t, level, *kv.Tags["tfstate"], "TF State Tag is not correct")
		}
	}
}

func TestLaunchpadResourceGroupHasStorageAccount(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		if !strings.Contains(rgName, "security") {
			storageAccount, err := tfState.GetStorageAccountByResourceGroup(rgName)
			if err != nil {
				panic(err)
			}

			storageAccountName := storageAccount.GetName()

			storageAccountExists := azure.StorageAccountExists(t, storageAccountName, rgName, tfState.SubscriptionID)
			assert.True(t, storageAccountExists, "storage account does not exist")

		}
	}
}

func TestLaunchpadStorageAccountHasTags(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		level := resourceGroup.GetLevel()

		if !strings.Contains(rgName, "security") {
			storageAccount, err := tfState.GetStorageAccountByResourceGroup(rgName)
			if err != nil {
				panic(err)
			}

			storageAccountName := storageAccount.GetName()
			localStorage, err := azure.GetStorageAccountE(storageAccountName, rgName, tfState.SubscriptionID)

			assert.NotNil(t, localStorage, fmt.Sprintf("Storage Account (%s) does not exists", storageAccountName))
			assert.NoError(t, err, "Storage Account couldn't read")
			assert.Equal(t, tfState.Environment, *localStorage.Tags["environment"], "Environment Tag is not correct")
			assert.Equal(t, tfState.Key, *localStorage.Tags["landingzone"], "LandingZone Tag is not correct")
			assert.Equal(t, level, *localStorage.Tags["level"], "Level Tag is not correct")

		}
	}
}

func TestLaunchpadStorageAccountHasTFStateContainer(t *testing.T) {
	t.Parallel()
	tfState := state.NewTerraformState(t, "launchpad")
	resourceGroups := tfState.GetResourceGroups()

	for _, resourceGroup := range resourceGroups {
		rgName := resourceGroup.GetName()
		if !strings.Contains(rgName, "security") {
			storageAccount, err := tfState.GetStorageAccountByResourceGroup(rgName)
			if err != nil {
				panic(err)
			}

			storageAccountName := storageAccount.GetName()
			containerName := "tfstate"

			exists := azure.StorageBlobContainerExists(t, containerName, storageAccountName, rgName, tfState.SubscriptionID)
			assert.True(t, exists, "TF State Container does not exist")

		}
	}
}
