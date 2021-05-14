package foundation

import (
	"testing"

	"secureaks/tests/util"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
)

type ExpectedValues struct {
	KeyVaultName              string
	KeyVaultResourceGroupName string
}

func TestKeyVault(t *testing.T) {
	t.Parallel()

	expectedValues := getExpectedValues()

	keyVaultName := util.ResolveNameWithPrefix(expectedValues.KeyVaultName)
	resourceGroupName := util.ResolveNameWithPrefix(expectedValues.KeyVaultResourceGroupName)

	// Test key vault exists
	keyVault := azure.GetKeyVault(t, resourceGroupName, keyVaultName, "")
	assert.Equal(t, keyVaultName, *keyVault.Name)
}

func TestManagedIdentity(t *testing.T) {
	t.Parallel()
	//TODO: Once Terrtest helper for Azure managed identity is developed, add tests for Azure managed identity.

}

func getExpectedValues() ExpectedValues {
	var expectedValues ExpectedValues
	util.ReadTestConfig("ExpectedValues", &expectedValues)
	return expectedValues
}
