package sharedservices

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/stretchr/testify/assert"
)

func TestKeyVault(t *testing.T) {
	t.Parallel()

	keyVaultName := fmt.Sprintf("%s-kv-secrets", os.Getenv("PREFIX"))
	resourceGroupName := fmt.Sprintf("%s-rg-aks-re1", os.Getenv("PREFIX"))

	// Test key vault exists
	keyVault := azure.GetKeyVault(t, resourceGroupName, keyVaultName, "")
	assert.Equal(t, keyVaultName, *keyVault.Name)
}

func TestResourceGroups(t *testing.T) {
	t.Parallel()

	// // Point to the folder holding resources groups
	// resourceGroupVarFile, err := filepath.Abs(string("../online/aks_secure_baseline/configuration/resource_groups.tfvars"))
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// resourceGroups, err := terraform.GetVariableAsMapFromVarFileE(t, resourceGroupVarFile, "resource_groups")
	// fmt.Println(resourceGroups)
	// for key := range resourceGroups {
	// 	exists := azure.ResourceGroupExists(t, "cmd-rg-"+key, "")
	// 	//Test Resource Groups Exists
	// 	assert.True(t, exists, "Resource group does not exist")
	// }
}

func TestLogAnalytics(t *testing.T) {
	t.Parallel()

	workSpaceName := fmt.Sprintf("%s-log-logs", os.Getenv("PREFIX"))
	resourceGroupName := fmt.Sprintf("%s-rg-ops_re1", os.Getenv("PREFIX"))
	workspaceExists := azure.LogAnalyticsWorkspaceExists(t, workSpaceName, resourceGroupName, "")
	assert.True(t, workspaceExists, "log analytics workspace not found.")
}
