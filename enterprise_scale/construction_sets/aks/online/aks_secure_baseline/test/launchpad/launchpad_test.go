package launchpad

import (
	"context"
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
)

type LandingZone struct {
	Level              int
	ResourceGroupName  string
	KeyVaultName       string
	StorageAccountName string
}

type TestStructure struct {
	Environment    string
	Prefix         string
	SubscriptionID string
	LandingZones   []LandingZone
}

func prepareTestTable() TestStructure {
	prefix := os.Getenv("PREFIX")

	test := TestStructure{
		Prefix:         prefix,
		SubscriptionID: os.Getenv("ARM_SUBSCRIPTION_ID"),
		Environment:    os.Getenv("ENVIRONMENT"),
		LandingZones:   make([]LandingZone, 0),
	}

	for iLoop := 0; iLoop < 4; iLoop++ {
		test.LandingZones = append(test.LandingZones, LandingZone{
			Level:              iLoop,
			ResourceGroupName:  fmt.Sprintf("%s-rg-caf-launchpad-level%d", prefix, iLoop),
			KeyVaultName:       fmt.Sprintf("%s-kv-level%d", prefix, iLoop),
			StorageAccountName: fmt.Sprintf("%sstcafl%d", prefix, iLoop),
		})
	}

	return test
}

func TestLaunchpadResourceGroupIsExists(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		exists := azure.ResourceGroupExists(t, landingZone.ResourceGroupName, test.SubscriptionID)

		assert.True(t, exists, fmt.Sprintf("Resource group (%s) does not exist", landingZone.ResourceGroupName))
	}
}

func TestLaunchpadResourceGroupIsExistsViaClient(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	client, _ := azure.GetResourceGroupClientE(test.SubscriptionID)

	for _, landingZone := range test.LandingZones {
		_, err := client.CheckExistence(context.Background(), landingZone.ResourceGroupName)

		assert.NoError(t, err, fmt.Sprintf("Resource group (%s) does not exist", landingZone.ResourceGroupName))
	}
}

func TestLaunchpadResourceGroupHasTags(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	client, errClient := azure.GetResourceGroupClientE(test.SubscriptionID)

	assert.NoError(t, errClient, "ResourceGroup Client couldn't read")

	for _, landingZone := range test.LandingZones {
		rg, errRG := client.Get(context.Background(), landingZone.ResourceGroupName)

		assert.NoError(t, errRG, fmt.Sprintf("ResourceGroup (%s) couldn't read", landingZone.ResourceGroupName))

		assert.Equal(t, test.Environment, *rg.Tags["environment"], "Environment Tag is not correct")
		assert.Equal(t, "launchpad", *rg.Tags["landingzone"], "LandingZone Tag is not correct")
		assert.Equal(t, fmt.Sprintf("level%d", landingZone.Level), *rg.Tags["level"], "Level Tag is not correct")
	}
}

func TestLaunchpadResourceGroupHasKeyVault(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		kv := azure.GetKeyVault(t, landingZone.ResourceGroupName, landingZone.KeyVaultName, test.SubscriptionID)

		assert.NotNil(t, kv, fmt.Sprintf("KeyVault (%s) does not exists", landingZone.KeyVaultName))
	}
}

func TestLaunchpadResourceGroupHasStorageAccount(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		exists := azure.StorageAccountExists(t, landingZone.StorageAccountName, landingZone.ResourceGroupName, test.SubscriptionID)

		assert.True(t, exists, fmt.Sprintf("Storage Account (%s) does not exists", landingZone.StorageAccountName))
	}
}

func TestLaunchpadKeyVaultHasSubscriptionIdSecret(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		exists := azure.KeyVaultSecretExists(t, landingZone.KeyVaultName, "subscription-id")

		assert.True(t, exists, "Subscription Id Secret does not exists")
	}
}

func TestLaunchpadKeyVaultHasTenantIdSecret(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		exists := azure.KeyVaultSecretExists(t, landingZone.KeyVaultName, "tenant-id")

		assert.True(t, exists, "Tenant Id Secret does not exists")
	}
}

func TestLaunchpadKeyVaultHasTags(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		kv := azure.GetKeyVault(t, landingZone.ResourceGroupName, landingZone.KeyVaultName, test.SubscriptionID)

		assert.Equal(t, test.Environment, *kv.Tags["environment"], "Environment Tag is not correct")
		assert.Equal(t, "launchpad", *kv.Tags["landingzone"], "LandingZone Tag is not correct")
		assert.Equal(t, fmt.Sprintf("level%d", landingZone.Level), *kv.Tags["level"], "Level Tag is not correct")
		assert.Equal(t, fmt.Sprintf("level%d", landingZone.Level), *kv.Tags["tfstate"], "TF State Tag is not correct")
	}
}

func TestLaunchpadStorageAccountHasTags(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		storage, err := azure.GetStorageAccountE(landingZone.StorageAccountName, landingZone.ResourceGroupName, test.SubscriptionID)

		assert.NoError(t, err, "Storage Account couldn't read")

		assert.Equal(t, test.Environment, *storage.Tags["environment"], "Environment Tag is not correct")
		assert.Equal(t, "launchpad", *storage.Tags["landingzone"], "LandingZone Tag is not correct")
		assert.Equal(t, fmt.Sprintf("level%d", landingZone.Level), *storage.Tags["level"], "Level Tag is not correct")
		assert.Equal(t, fmt.Sprintf("level%d", landingZone.Level), *storage.Tags["tfstate"], "TF State Tag is not correct")
	}
}

func TestLaunchpadStorageAccountHasTFStateContainer(t *testing.T) {
	t.Parallel()

	test := prepareTestTable()

	for _, landingZone := range test.LandingZones {
		containerName := "tfstate"

		exists := azure.StorageBlobContainerExists(t, containerName, landingZone.StorageAccountName, landingZone.ResourceGroupName, test.SubscriptionID)

		assert.True(t, exists, "TF State Container does not exist")
	}
}
